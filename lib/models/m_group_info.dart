import 'package:collection/collection.dart';
import 'package:hshh/services/s_group_info.dart';

class CourseInfo {
  final String id;
  final String groupId;
  final String bookingId;

  Uri get webLink => GroupInfoService.getCourseLink(groupId);

  const CourseInfo(
      {required this.id, required this.groupId, required this.bookingId});
}

class GroupInfo {
  final String groupId;
  final String description;
  final Uri? imageURL;

  final String bsCode;
  final List<CourseInfo>? courses;

  const GroupInfo(
      {required this.groupId,
      required this.description,
      this.imageURL,
      required this.bsCode,
      this.courses});

  Uri get webLink => GroupInfoService.getCourseLink(groupId);

  CourseInfo? course(String id) => courses?.firstWhereOrNull((e) => e.id == id);

  @override
  int get hashCode => [groupId, description, imageURL, bsCode, courses]
      .map((e) => e.hashCode)
      .join()
      .hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}
