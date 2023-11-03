import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hshh/util/json_tools.dart';

typedef Profile = JsonMap<String>;

class StorageService {
  static Future<Box> get _profileBox => Hive.openBox('profile');

  static Future<Map<int, Profile>> profileList() async => (await _profileBox)
      .values
      .cast<Map>()
      .map((e) =>
          e.map((key, value) => MapEntry(key.toString(), value.toString())))
      .toList()
      .asMap();

  static Future<Profile> profileGet(int key) async =>
      (await _profileBox).get(key)!;

  static Future<void> profileSet(int? key, Profile profile) async =>
      await (await _profileBox).put(key ?? (await _profileBox).length, profile);

  static Future<void> profileDelete(int key) async =>
      await (await _profileBox).delete(key);
}
