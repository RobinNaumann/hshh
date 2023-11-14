import 'dart:convert';
import 'dart:math' as math;

import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/api_tools.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/util/tools.dart';
import 'package:html_character_entities/html_character_entities.dart';

class CoursesService {
  static Future<CoursesInfo> getCoursesInfo() async {
    final data = _sanitizeJson(await apiGet(
        uri: Uri.https("buchung.hochschulsport-hamburg.de",
            "/angebote/aktueller_zeitraum/kurssuche.js")));

    return CoursesInfo(
        categories: _parseCategories(data["bereiche"]),
        locations: _parseLocations(data["orte"]),
        groups: _groupCourses(
            _parseCourses(data["kurse"], data["tage"], data["bereiche"])));
  }

  static JsonMap _sanitizeJson(String s) {
    s = s.replaceAll("<wbr>", "");
    return json.decode(s.substring(math.max(0, s.indexOf("{"))),
        reviver: (key, value) =>
            value is String ? HtmlCharacterEntities.decode(value) : value);
  }

  static Map<int, String> _parseCategories(List c) =>
      c.map((e) => "$e").toList().asMap();

  static Map<int, EventLocation> _parseLocations(List locations) {
    var err = false;
    Map<int, EventLocation> res = {};
    for (int i = 0; i < locations.length; i++) {
      try {
        final l = locations[i];
        res[i] = EventLocation(name: l[0], lat: l[1], long: l[2]);
      } catch (e) {
        logger.t("courses_service: a EventLocation could not be parsed");
        err = true;
      }
    }
    if (res.isEmpty && err) throw Exception();
    return res;
  }

  static List<double?> _parseCost(String c) {
    if (c.contains("title='free of charge'")) return [];
    return c
        .replaceAll("&nbsp;&euro;", "")
        .split("/")
        .map((e) => double.tryParse(e))
        .toList();
  }

  static List<CourseEvent> _parseEvents(List c, List days) {
    List<CourseEvent> events = [];

    for (int i = 0; i < 5; i++) {
      //parse days
      int day = c[4][i];
      List dd = days[day];
      for (int j = 0; j < 7; j++) {
        if (dd[j + 1] != 1) continue;
        events.add(CourseEvent(
          weekday: j,
          locationId: c[6][i],
          timespan: c[5][i],
        ));
      }
    }

    return events;
  }

  static CourseType _parseType(List course, String category) {
    if (course[0] < 0) return CourseType.info;
    if (course[0] != 100) return CourseType.course;
    return (course[3].toLowerCase().contains("schwimm") ||
            category.contains("Wassersport"))
        ? CourseType.courseSwimcard
        : CourseType.courseFlexicard;
  }

  static List<CourseGroup> _groupCourses(List<Course> courses) =>
      courses.fold(<String>{}, (p, e) => p..add(e.groupName)).fold(
          [],
          (p, e) => p
            ..add(CourseGroup(
                name: e,
                allCourses: courses.where((c) => c.groupName == e).toList())));

  static List<Course> _parseCourses(List courses, List days, List categories) {
    List<Course> res = [];
    for (int i = 0; i < courses.length; i++) {
      try {
        final c = courses[i];

        res.add(Course(
            id: c[1],
            groupName: c[2],
            courseName: c[3],
            events: _parseEvents(c, days),
            timespan: c[7],
            organizers: c[8],
            cost: _parseCost(c[9]),
            spacesAvailable: c[10] == 1,
            categoryId: c[12],
            type: _parseType(c, categories[c[12]])));
      } catch (e) {
        logger.t("courses_service: a Course could not be parsed", error: e);
      }
    }
    return res;
  }
}
