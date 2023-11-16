import 'package:hshh/models/m_data.dart';

enum EventTimeState {
  bookable,
  closed,
  waitinglist;

  bool get isBookable => this == EventTimeState.bookable;
  bool get isClosed => this == EventTimeState.closed;
  bool get isWaitinglist => this == EventTimeState.waitinglist;
}

class EventTime extends DataModel {
  final DateTime start;
  final DateTime end;
  final EventTimeState state;
  final String? bookingId;

  const EventTime(
      {required this.start,
      required this.end,
      required this.state,
      this.bookingId});

  @override
  get fields =>
      {"start": start, "end": end, "state": state, "bookingId": bookingId};
}
