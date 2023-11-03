import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/cubits/c_courses.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/course_page/v_event_map.dart';
import 'package:lucide_icons/lucide_icons.dart';

class EventView extends StatelessWidget {
  final CourseEvent event;
  const EventView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final location = context.read<CoursesCubit>().getLocation(event.locationId);

    Widget _timeView() => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 40,
                child: Icon(LucideIcons.calendar),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(CoursesCubit.getWeekday(event.weekday, long: true) ??
                      "--"),
                  Text(event.timespan)
                ],
              ),
            )
          ],
        );

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: boxDeco,
      child: Column(
        children: [
          _timeView(),
          if (location != null) EventMapView(location: location),
        ].spaced(),
      ),
    );
  }
}
