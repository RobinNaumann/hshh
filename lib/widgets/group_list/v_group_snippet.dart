import 'package:flutter/material.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tools.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../models/m_course.dart';
import '../group_page/p_course_group.dart';

class GroupSnippet extends StatelessWidget {
  final CourseGroup group;

  const GroupSnippet({super.key, required this.group});

  String _courseCount(int c) => c == 0 ? "" : "$c Kurs${c == 1 ? '' : 'e'}";

  Widget _cardType() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (group.flexicard) const Icon(LucideIcons.creditCard),
          if (group.swimcard) const Icon(LucideIcons.waves),
        ].spaced(amount: 10, horizontal: true),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourseGroupPage(group: group)),
      ),
      child: box(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(group.name, style: title.copyWith(fontSize: 16)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Text(_courseCount(group.courses.length))),
                Expanded(child: _cardType())
              ],
            )
          ],
        ),
      ),
    );
  }
}
