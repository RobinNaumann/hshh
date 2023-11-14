import 'package:hshh/services/s_event_times.dart';

import '../util/tri/tri_cubit.dart';

class EventTimesCubit extends TriCubit<EventTimesSession> {
  static const provider = TriProvider<EventTimesCubit>;
  static const builder = TriCubit.builder<EventTimesCubit, EventTimesSession>;

  EventTimesCubit(
      {required String bsCode,
      required String bookingId,
      required String groupId})
      : super(() => EventTimesService.getTimes(groupId, bsCode, bookingId));

  String get sessionId => state.whenOrNull(onData: (d) => d.sessionId)!;
}
