import 'package:flutter/material.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/models/m_group_info.dart';
import 'package:hshh/util/extensions/widget_list.dart';

import 'v_course_snippet.dart';

class CourseList extends StatelessWidget {
  final GroupInfo groupInfo;
  final List<Course> courses;

  const CourseList({super.key, required this.courses, required this.groupInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: courses
            .map((e) => e.withBookingId(groupInfo.bookingId(e.id)))
            .map((c) => CourseSnippet(course: c))
            .spaced(amount: 20)
          ..add(const SizedBox(height: 50)));
  }
}
