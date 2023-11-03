import 'package:flutter/material.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/widgets/group_page/p_course_group.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../services/s_courses.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  CoursesInfo? coursesInfo;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    final c = await CoursesService.getCoursesInfo();
    setState(() => coursesInfo = c);
  }

  @override
  Widget build(BuildContext context) {
    return coursesInfo == null
        ? const CircularProgressIndicator.adaptive()
        : ListView.builder(
            itemCount: coursesInfo!.groups.length,
            itemBuilder: (_, i) => GroupSnippet(group: coursesInfo!.groups[i]));
  }
}

class GroupSnippet extends StatelessWidget {
  final CourseGroup group;

  const GroupSnippet({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourseGroupPage(group: group)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100),
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(group.name),
                  Text(group.courses.length.toString()),
                ],
              ),
            ),
            Column(
              children: [
                if (group.flexicard) const Icon(LucideIcons.creditCard),
                if (group.swimcard) const Icon(LucideIcons.waves),
              ],
            )
          ],
        ),
      ),
    );
  }
}
