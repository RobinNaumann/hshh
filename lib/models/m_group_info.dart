import 'package:hshh/util/extensions/maybe_map.dart';

class GroupInfo {
  final String description;
  final Uri? imageURL;
  final Map<String, String>? mappings;

  const GroupInfo({required this.description, this.imageURL, this.mappings});

  String? bookingId(String id) => mappings?.maybe(id.trim());
}
