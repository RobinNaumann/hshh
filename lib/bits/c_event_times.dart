import 'package:hshh/services/s_event_times.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

class EventTimesBit extends TriBit<EventTimesSession> {
  static const builder = TriBuilder<EventTimesSession, EventTimesBit>.make;

  EventTimesBit(
      {required String bsCode,
      required String bookingId,
      required String groupId})
      : super(() => EventTimesService.getTimes(groupId, bsCode, bookingId));

  String get sessionId => state.whenOrNull(onData: (d) => d.sessionId)!;
}
