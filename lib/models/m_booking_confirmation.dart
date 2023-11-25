import 'package:hshh/models/m_data.dart';
import 'package:hshh/services/d_institutions.dart';
import 'package:hshh/util/elbe_ui/src/util/unix_date.dart';
import 'package:hshh/util/json_tools.dart';

class BookingConfirmation extends DataModel {
  final String groupName;
  final String? courseName;
  final String? address;

  final int? starttime;
  final int? endtime;

  final String profileEmail;
  final String? profileName;
  final String? profileInst;

  final String bookingId;
  final String formdataId;

  bool get isInPast =>
      starttime != null &&
      (starttime! + 1000 * 60 * 60 * 5) <= DateTime.now().asUnixMs;

  const BookingConfirmation(
      {required this.groupName,
      this.courseName,
      this.address,
      this.starttime,
      this.endtime,
      required this.profileEmail,
      required this.profileName,
      this.profileInst,
      required this.bookingId,
      required this.formdataId});

  @override
  get map => {
        "groupName": groupName,
        "courseName": courseName,
        "address": address,
        "starttime": starttime,
        "endtime": endtime,
        "profileEmail": profileEmail,
        "profileName": profileName,
        "profileInst": profileInst,
        "bookingId": bookingId,
        "formdataId": formdataId
      };

  factory BookingConfirmation.fromMap(JsonMap map) => BookingConfirmation(
      groupName: map.asCast("groupName"),
      courseName: map.maybeCast("courseName"),
      address: map.maybeCast("address"),
      starttime: map.maybeCast("starttime"),
      endtime: map.maybeCast("endtime"),
      profileEmail: map.maybeCast("profileEmail"),
      profileName: map.maybeCast("profileName"),
      profileInst: map.maybeCast("profileInst"),
      bookingId: map.asCast("bookingId"),
      formdataId: map.asCast("formdataId"));
}
