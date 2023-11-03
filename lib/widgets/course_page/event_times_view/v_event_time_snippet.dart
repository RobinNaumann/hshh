import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/cubits/c_event_times.dart';
import 'package:hshh/models/m_event_time.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/booking_page/p_booking.dart';

class EventTimeSnippet extends StatelessWidget {
  final EventTime eventTime;

  const EventTimeSnippet({super.key, required this.eventTime});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => eventTime.state == EventTimeState.bookable
            ? pushPage(
                context,
                BookingPage(
                    dateId: eventTime.bookingId!,
                    sessionId: context.read<EventTimesCubit>().sessionId))
            : null,
        child: Container(
            decoration: boxDeco.copyWith(
                color: eventTime.state == EventTimeState.bookable
                    ? Colors.teal.shade100
                    : null),
            padding: const EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(eventTime.start.toIso8601String()),
                  Text(eventTime.state.name)
                ])));
  }
}
