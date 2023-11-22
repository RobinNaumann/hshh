import 'package:hshh/models/m_course.dart';
import 'package:hshh/services/s_courses.dart';
import 'package:hshh/util/extensions/maybe_map.dart';

import '../util/tri/tribit/tribit.dart';

class CoursesBit extends TriBit<CoursesInfo> {
  static const builder = TriBuilder<CoursesInfo, CoursesBit>.make;

  CoursesBit() : super(() => CoursesService.getCoursesInfo());

  String? getCategory(int index) =>
      state.whenOrNull<String?>(onData: (d) => d.categories.maybe(index));

  EventLocation? getLocation(int index) =>
      state.whenOrNull<EventLocation?>(onData: (d) => d.locations.maybe(index));

  static String? getWeekday(int index,
          {bool withDot = false, bool long = false, bool withS = false}) =>
      (long || withS
              ? [
                  "Montag",
                  "Dienstag",
                  "Mittwoch",
                  "Donnerstag",
                  "Freitag",
                  "Samstag",
                  "Sonntag"
                ]
              : ["Mo", "Di", "Mi", "Do", "Fr", "Sa", "So"])
          .maybe(index)
          ?.add(withDot ? "." : null)
          .add(withS ? "s" : null);
}
