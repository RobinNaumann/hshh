import 'package:hshh/bits/c_group_info.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
import 'package:hshh/widgets/course_page/v_event.dart';
import 'package:hshh/widgets/group_page/course_list/v_course_snippet.dart';

import '../../util/elbe_ui/elbe.dart';
import '../favorites/v_fav_btn.dart';
import 'event_times_view/v_event_times.dart';

class CoursePage extends StatelessWidget {
  final Course course;
  final GroupInfoBit? bit;

  const CoursePage({super.key, re, required this.bit, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //heroTag: "course_${course.id}",
      leadingIcon: const LeadingIcon.close(),
      actions: [CourseFavButton(courseId: course.id)],
      title: course.groupName,
      body: Padded.all(
        child: ListView(
          clipBehavior: Clip.none,
          children: [
            course.courseName.trim().isEmpty
                ? CourseSnippet.noName(false)
                : Text.h6(course.courseName),
            SingleChildScrollView(
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: course.events
                        .listMap((e) => Box.plain(
                              constraints: const RemConstraints(maxWidth: 15),
                              child: EventView(event: e),
                            ))
                        .spaced())),
            const Title.h5("Nächste Termine"),
            TriProvider.adaptive(
                value: bit,
                create: (_) => GroupInfoBit(course.groupName),
                child:
                    EventTimesView(course: course, isFree: course.cost.isEmpty))
          ].spaced(),
        ),
      ),
    );
  }
}
