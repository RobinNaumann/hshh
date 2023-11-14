import 'package:hshh/models/m_course.dart';
import 'package:hshh/models/m_group_info.dart';

import '../../../util/elbe_ui/elbe.dart';
import 'v_course_snippet.dart';

class CourseList extends StatelessWidget {
  final GroupInfo groupInfo;
  final List<Course> courses;

  const CourseList({super.key, required this.courses, required this.groupInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: courses.map((c) => CourseSnippet(course: c)).spaced()
          ..add(const SizedBox(height: 50)));
  }
}
