
import 'package:hive/hive.dart';
import 'package:hshh/util/json_tools.dart';

typedef Profile = JsonMap<String>;

class StorageService {
  static Future<Box> get _profileBox => Hive.openBox('profile');
  static Future<Box> get _prefBox => Hive.openBox('preferences');

  //PROFILES

  static Future<Map<int, Profile>> profileList() async =>
      (await _profileBox).toMap().map<int, Profile>((k, v) => MapEntry(
          k,
          v.map<String, String>(
              (key, value) => MapEntry(key.toString(), value.toString()))));

  static Future<Profile> profileGet(int id) async =>
      (await _profileBox).get(id)!;

  static Future<int> profileSet(int? id, Profile profile) async {
    if (id != null) {
      await (await _profileBox).put(id, profile);
      return id;
    }
    return await (await _profileBox).add(profile);
  }

  static Future<void> profileDelete(int id) async =>
      await (await _profileBox).delete(id);

  // FAVORITES

  static Future<List<String>> favoriteList() async =>
      await (await _prefBox).get("favorites") ?? [];

  static Future<void> favoriteAdd(String id) async =>
      _favoriteUpdate((l) => [...l, id]);

  static Future<void> favoriteRemove(String id) async =>
      _favoriteUpdate((l) => l.where((e) => e != id).toList());

  static Future _favoriteUpdate(List<String> Function(List<String>) f) async =>
      await (await _prefBox).put("favorites", (f(await favoriteList())));
}
