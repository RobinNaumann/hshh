import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hshh/cubits/c_courses.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/course_page/p_course.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../models/m_course.dart';

class CourseSnippet extends StatelessWidget {
  final Course course;

  const CourseSnippet({super.key, required this.course});

  String _getDays(BuildContext c) =>
      course.days.map((i) => CoursesCubit.getWeekday(i) ?? "").join(" ");
  String _getLocations(BuildContext c) => course.locations
      .map((i) => c.read<CoursesCubit>().getLocation(i)?.name ?? "")
      .join("\n");

  Widget _costView(CourseType type, List<double?> cost) {
    if (type == CourseType.courseFlexicard ||
        type == CourseType.courseSwimcard) {
      return Icon(type == CourseType.courseFlexicard
          ? LucideIcons.creditCard
          : LucideIcons.waves);
    }

    return Text(
        cost.isNotEmpty
            ? (cost[0] != null ? "${cost[0]!.toStringAsFixed(2)}€" : "kA")
            : "??",
        style: GoogleFonts.calistoga(
            //color: Colors.blue.shade900,
            fontSize: 15));
  }

  Widget _dataEntry(IconData icon, String label) => Row(
        children: [
          Icon(
            icon,
            size: 18,
          ),
          const SizedBox(width: 7),
          Expanded(child: Text(label))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return _CourseSnippetBase(
        spacesAvailable: course.spacesAvailable,
        child: InkWell(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CoursePage(course: course)),
                ),
            child: box(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        course.courseName,
                        style: GoogleFonts.calistoga(fontSize: 16),
                      ),
                      _dataEntry(LucideIcons.clock, _getDays(context)),
                      _dataEntry(LucideIcons.mapPin, _getLocations(context)),
                    ].spaced(),
                  ),
                ),
                _costView(course.type, course.cost)
              ],
            ))));
  }
}

// base

class _CourseSnippetBase extends StatelessWidget {
  final Widget child;
  final bool spacesAvailable;
  const _CourseSnippetBase(
      {required this.child, required this.spacesAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: spacesAvailable ? null : Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            if (!spacesAvailable)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                child: Text(
                  "ausgebucht".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white),
                ),
              )
          ],
        ));
  }
}
