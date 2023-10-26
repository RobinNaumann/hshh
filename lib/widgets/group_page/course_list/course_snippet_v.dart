import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tools.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../models/course.dart';

class CourseSnippet extends StatelessWidget {
  final Course course;

  const CourseSnippet({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
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

    return _CourseSnippetBase(
        spacesAvailable: course.spacesAvailable,
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
                  _dataEntry(LucideIcons.clock, "Do.  12:30-14:00"),
                  _dataEntry(LucideIcons.mapPin, "Turnhalle X"),
                ].spaced(),
              ),
            ),
            Text(
              "13.00€",
              style: GoogleFonts.calistoga(
                  color: Colors.blue.shade900, fontSize: 15),
            )
          ],
        )));
  }
}

// base

class _CourseSnippetBase extends StatelessWidget {
  final Widget child;
  final bool spacesAvailable;
  const _CourseSnippetBase(
      {super.key, required this.child, required this.spacesAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            /*boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: -2,
                blurRadius: 11,
                offset: const Offset(0, 2),
              )
            ],*/
            borderRadius: BorderRadius.circular(10),
            color: spacesAvailable ? null : Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            if (!spacesAvailable)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                child: Text(
                  "ausgebucht".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.white),
                ),
              )
          ],
        ));
  }
}
