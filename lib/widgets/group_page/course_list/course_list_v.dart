import 'package:flutter/material.dart';
import 'package:hshh/models/course.dart';
import 'package:hshh/util/extensions/widget_list.dart';

import 'course_snippet_v.dart';

class CourseList extends StatelessWidget {
  final List<Course> courses;

  const CourseList({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:
            courses.map((c) => CourseSnippet(course: c)).spaced(amount: 20)
              ..add(const SizedBox(height: 50)));
  }
}
