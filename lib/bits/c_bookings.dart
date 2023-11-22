import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/models/m_booking_confirmation.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

class BookingsBit extends TriBit<List<BookingConfirmation>> {
  static const builder =
      TriBuilder<List<BookingConfirmation>, BookingsBit>.make;

  BookingsBit() : super(() => StorageService.bookingList());

  void delete(String id) {
    //StorageService.bookingDelete(id);
    reload(silent: true);
  }
}
