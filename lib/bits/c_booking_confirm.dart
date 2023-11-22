import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/models/m_event_time.dart';
import 'package:hshh/services/s_booking.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

import '../models/m_course.dart';

class BookingConfBit extends TriBit<Confirmation> {
  static const builder = TriBuilder<Confirmation, BookingConfBit>.make;

  BookingConfBit({required BookingReqData data})
      : super(() => BookingService.confirm(data: data));
}
