import 'package:countly_flutter/countly_flutter.dart';
import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/services/s_booking.dart';
import 'package:hshh/services/s_devlog.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

class BookBit extends TriBit<BookingResponse> {
  final Confirmation confirmation;
  final BookingReqData data;
  static const builder = TriBuilder<BookingResponse, BookBit>.make;

  BookBit({required this.confirmation, required this.data})
      : super(() async {
          final res =
              await BookingService.book(confirmation: confirmation, data: data);
          if (res.confirmation != null) {
            await StorageService.bookingAdd(res.confirmation!);
          } else if (res.htmlMessage == null) {
            throw Exception(
                "response is neither a confirmation, nor a message");
          }
          DevLog.event("book",
              {"groupId": data.course.groupName, "courseId": data.course.id});
          return res;
        });
}
