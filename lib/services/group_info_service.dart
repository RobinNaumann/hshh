import 'package:hshh/models/group_info.dart';
import 'package:hshh/util/api_tools.dart';
import 'package:hshh/util/tools.dart';
import 'package:html/parser.dart';

class GroupInfoService {
  static const host = "buchung.hochschulsport-hamburg.de";
  static Uri _makeUrl(String groupName) => Uri.https(
      host, "/angebote/aktueller_zeitraum/${_parseFilename(groupName)}.html");

  static Uri fileUrl(String path) =>
      path.startsWith("http") ? Uri.parse(path) : Uri.https(host, path);

  static String _parseFilename(String groupName) =>
      ("_") +
      groupName
          .replaceAll("&", "und")
          .replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), "_");

  static Future<GroupInfo> getInfo(String groupName) async {
    final res = await apiGet(uri: _makeUrl(groupName));
    final html = parse(res);
    final bs = html.getElementsByClassName("bs_kursbeschreibung");

    // get first image path

    Uri? image;

    try {
      image = fileUrl(
          bs.firstOrNull!.getElementsByTagName("img").first.attributes["src"]!);
    } catch (e) {
      logger.w("could not parse image for '$groupName'", error: e);
    }

    return GroupInfo(description: bs.first.innerHtml, imageURL: image);
  }
}
