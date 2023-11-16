import 'package:collection/collection.dart';
import 'package:hshh/models/m_data.dart';
import 'package:hshh/services/s_group_info.dart';
import 'package:hshh/util/json_tools.dart';

class CourseInfo extends DataModel {
  final String id;
  final String groupId;
  final String bookingId;

  Uri get webLink => GroupInfoService.getCourseLink(groupId);

  const CourseInfo(
      {required this.id, required this.groupId, required this.bookingId});

  @override
  get fields => {"id": id, "groupId": groupId, "bookingId": bookingId};
}

class GroupInfo extends DataModel {
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
  get fields =>
      {"groupId": groupId, "description": description, "imageURL": imageURL};
}
