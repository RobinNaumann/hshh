import 'package:hshh/models/m_data.dart';

class CoursesInfo extends DataModel {
  final Map<int, EventLocation> locations;
  final Map<int, String> categories;
  final List<CourseGroup> groups;

  const CoursesInfo(
      {required this.locations,
      required this.categories,
      required this.groups});

  @override
  get fields =>
      {"locations": locations, "categories": categories, "groups": groups};
}

class EventLocation {
  final String name;
  final double lat;
  final double long;

  const EventLocation(
      {required this.name, required this.lat, required this.long});

  @override
  String toString() => "EventLocation{"
      "name: $name, "
      "lat: $lat, "
      "long: $long}";
}

class CourseEvent extends DataModel {
  final int weekday;
  final int locationId;
  final String timespan;
  final int? bookingId;

  const CourseEvent(
      {required this.weekday,
      required this.locationId,
      required this.timespan,
      this.bookingId});

  CourseEvent withId(int bookingId) => CourseEvent(
      weekday: weekday,
      locationId: locationId,
      timespan: timespan,
      bookingId: bookingId);

  @override
  get fields => {
        "weekday": weekday,
        "locationId": locationId,
        "timespan": timespan,
        "bookingId": bookingId
      };
}

enum CourseType { info, course, courseFlexicard, courseSwimcard }

class CourseGroup extends DataModel {
  final String name;
  final List<Course> allCourses;

  List<Course> get courses =>
      allCourses.where((c) => c.type != CourseType.info).toList();

  const CourseGroup({required this.name, required this.allCourses});

  bool get flexicard =>
      allCourses.indexWhere((c) => c.type == CourseType.courseFlexicard) >= 0;

  bool get swimcard =>
      allCourses.indexWhere((c) => c.type == CourseType.courseSwimcard) >= 0;

  @override
  get fields => {"name": name, "allCourses": allCourses};
}

class Course extends DataModel {
  final String id;
  final String groupName;
  final String courseName;
  final List<CourseEvent> events;
  final String timespan;
  final String organizers;
  final List<double?> cost;
  final bool spacesAvailable;
  final int categoryId;

  final CourseType type;

  List<int> get locations => events.map((e) => e.locationId).toList();

  Set<int> get days => events.fold({}, (p, e) => p..add(e.weekday));

  const Course(
      {required this.id,
      required this.groupName,
      required this.courseName,
      required this.events,
      required this.timespan,
      required this.organizers,
      required this.cost,
      required this.spacesAvailable,
      required this.categoryId,
      required this.type});

  @override
  get fields => {
        "id": id,
        "groupName": groupName,
        "courseName": courseName,
        "events": events,
        "timespan": timespan,
        "organizers": organizers,
        "cost": cost,
        "spacesAvailable": spacesAvailable,
        "categoryId": categoryId,
        "type": type
      };
}
