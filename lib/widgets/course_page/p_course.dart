import 'package:flutter/material.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/course_page/v_event.dart';

import 'event_times_view/v_event_times.dart';

class CoursePage extends StatelessWidget {
  final Course course;

  const CoursePage({super.key, re, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(course.courseName, style: title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              ...course.events.listMap((e) => EventView(event: e)),
              course.bookingId != null
                  ? EventTimesView(bookingId: course.bookingId!)
                  : const Text("Buchungsdaten nicht verfügbar",
                      textAlign: TextAlign.center)
            ].spaced(),
          ),
        ));
  }
}
