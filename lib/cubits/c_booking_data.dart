import 'package:hshh/services/s_booking.dart';

import '../util/tri/tri_cubit.dart';

class BookingDataCubit extends TriCubit<BookingData> {
  static const provider = TriCubit.provider<BookingDataCubit>;
  static const builder = TriCubit.builder<BookingDataCubit, BookingData>;

  BookingDataCubit(String dateId, String sessionId)
      : super(() => BookingService.data(dateId, sessionId));
}
