import 'package:hshh/services/s_event_times.dart';

import '../util/tri/tri_cubit.dart';

class EventTimesCubit extends TriCubit<EventTimesSession> {
  static const provider = TriCubit.provider<EventTimesCubit>;
  static const builder = TriCubit.builder<EventTimesCubit, EventTimesSession>;

  EventTimesCubit({required String bookingId})
      : super(() => EventTimesService.getTimes(bookingId));

  String get sessionId => state.whenOrNull(onData: (d) => d.sessionId)!;
}
