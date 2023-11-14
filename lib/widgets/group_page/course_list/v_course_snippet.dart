import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/cubits/c_courses.dart';
import 'package:hshh/widgets/course_page/p_course.dart';
import 'package:hshh/widgets/home/v_card_icon.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../cubits/c_group_info.dart';
import '../../../models/m_course.dart';
import '../../../util/elbe_ui/elbe.dart';

class CourseSnippet extends StatelessWidget {
  final bool showGroupname;
  final Course course;

  const CourseSnippet(
      {super.key, required this.course, this.showGroupname = false});

  String _getLocations(BuildContext c) => course.locations
      .map((i) => c.read<CoursesCubit>().getLocation(i)?.name ?? "")
      .join("\n");

  Widget _costView(CourseType type, List<double?> cost) {
    if (type == CourseType.courseFlexicard ||
        type == CourseType.courseSwimcard) {
      return type == CourseType.courseFlexicard
          ? const CardIcon.flexi()
          : const CardIcon.swim();
    }

    return Text.bodyL(
        cost.isNotEmpty
            ? (cost[0] != null ? "${cost[0]!.toStringAsFixed(2)}€" : "k.A.")
            : "??",
        variant: TypeVariants.bold);
  }

  static Widget noName(bool integrated) => integrated
      ? const Text.h6("Angebot ohne Name", colorState: ColorStates.disabled)
      : Padded.only(
          top: 1,
          bottom: 0.6,
          child: const Text.h6("Angebot ohne Name",
              colorState: ColorStates.disabled));

  Widget _dataEntry(IconData icon, Widget value) => Row(
        children: [
          Icon(icon, style: TypeStyles.bodyS),
          const Spaced(width: 1),
          Expanded(child: value)
        ],
      );

  @override
  Widget build(BuildContext context) {
    final loc = _getLocations(context);
    final name = course.courseName;

    return _CourseSnippetBase(
        spacesAvailable: course.spacesAvailable,
        child: Card(
            heroTag: "course_${course.id}",
            border: Border.none,
            style: ColorStyles.plain,
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CoursePage(
                          course: course,
                          cubit: context.read<GroupInfoCubit?>())),
                ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    name.trim().isEmpty ? noName(true) : Text.h6(name),
                    if (showGroupname)
                      Text.bodyM(course.groupName, variant: TypeVariants.bold),
                    _dataEntry(
                        LucideIcons.clock, WeekdayView(days: course.days)),
                    if (loc.trim().isNotEmpty)
                      _dataEntry(LucideIcons.mapPin, Text(loc)),
                  ].spaced(),
                )),
                _costView(course.type, course.cost)
              ].spaced(),
            )));
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
    return Card(

        //scheme: ColorSchemes.inverse,
        style: spacesAvailable ? null : ColorStyles.minorAlertWarning,
        //border: Border.none,
        padding: RemInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            child,
            if (!spacesAvailable)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                child: Text.bodyS("warteliste".toUpperCase(),
                    variant: TypeVariants.bold, textAlign: TextAlign.center),
              )
          ],
        ));
  }
}

class WeekdayView extends StatelessWidget {
  static const List<String> _names = ["M", "D", "M", "D", "F", "S", "S"];
  final Set<int> days;

  const WeekdayView({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Card(
      border: Border.noneRect,
      padding: RemInsets.zero,
      color: Colors.transparent,
      child: Row(
          children: _names
              .mapIndexed((i, e) => Text(
                    e,
                    colorState: days.contains(i)
                        ? ColorStates.neutral
                        : ColorStates.disabled,
                    variant: days.contains(i)
                        ? TypeVariants.bold
                        : TypeVariants.regular,
                  ))
              .spaced(amount: 0.3)),
    );
  }
}
