import 'package:flutter/material.dart';
import 'package:hshh/cubits/c_event_times.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tri/tri_cubit.dart';
import 'package:hshh/widgets/course_page/event_times_view/v_event_time_snippet.dart';

class EventTimesView extends StatelessWidget {
  final String bookingId;
  const EventTimesView({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return EventTimesCubit.provider(
        cubit: EventTimesCubit(bookingId: bookingId),
        child: EventTimesCubit.builder(
            onLoading: loadingView,
            onError: errorView,
            onData: (c, data) => data.times.isEmpty
                ? const Text("TODO: keine Termine verfügbar")
                : Column(
                    children: data.times
                        .listMap((e) => EventTimeSnippet(eventTime: e))
                        .spaced(),
                  )));
  }
}
