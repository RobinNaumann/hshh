import 'package:hshh/models/m_booking_data.dart';
import 'package:hshh/services/s_booking.dart';

import '../util/tri/tri_cubit.dart';

class BookingDataCubit extends TriCubit<BookingData> {
  final String dateId;
  final String sessionId;

  static const provider = TriCubit.provider<BookingDataCubit>;
  static const builder = TriCubit.builder<BookingDataCubit, BookingData>;

  BookingDataCubit(this.dateId, this.sessionId)
      : super(() => BookingService.data(dateId, sessionId));
}
