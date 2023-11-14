import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/cubits/c_group_info.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/widgets/course_page/v_event.dart';
import 'package:hshh/widgets/group_page/course_list/v_course_snippet.dart';

import '../../util/elbe_ui/elbe.dart';
import '../favorites/v_fav_btn.dart';
import 'event_times_view/v_event_times.dart';

class CoursePage extends StatelessWidget {
  final Course course;
  final GroupInfoCubit? cubit;

  const CoursePage({super.key, re, required this.cubit, required this.course});

  Widget _child() {
    print("BUILD _CHILD");
    return EventTimesView(courseId: course.id, isFree: course.cost.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      heroTag: "course_${course.id}",
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
            cubit != null
                ? BlocProvider<GroupInfoCubit>.value(
                    value: cubit!, child: _child())
                : BlocProvider(
                    create: (_) => GroupInfoCubit(course.groupName),
                    child: _child(),
                  )
          ].spaced(),
        ),
      ),
    );
  }
}
