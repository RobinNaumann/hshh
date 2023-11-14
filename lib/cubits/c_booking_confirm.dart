import 'package:hshh/services/s_booking.dart';

import '../util/tri/tri_cubit.dart';

class BookingConfCubit extends TriCubit<Confirmation> {
  static const provider = TriCubit.provider<BookingConfCubit>;
  static const builder = TriCubit.builder<BookingConfCubit, Confirmation>;

  BookingConfCubit(BookingReqData data)
      : super(() => BookingService.confirm(data));
}
