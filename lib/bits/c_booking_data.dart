import 'package:hshh/models/m_booking_data.dart';
import 'package:hshh/models/m_event_time.dart';
import 'package:hshh/services/s_booking.dart';

import '../models/m_course.dart';
import '../util/tri/tribit/tribit.dart';

class BookingDataBit extends TriBit<BookingData> {
  static const builder = TriBuilder<BookingData, BookingDataBit>.make;
  final String dateId;
  final String sessionId;
  final Course course;
  final EventTime time;

  BookingDataBit(this.dateId, this.sessionId, this.course, this.time)
      : super(() => BookingService.data(dateId, sessionId));
}
