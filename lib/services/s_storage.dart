import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:hshh/bits/c_preferences.dart';
import 'package:hshh/models/m_booking_confirmation.dart';
import 'package:hshh/util/elbe_ui/src/theme/themes/color/color_theme_data.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/util/tools.dart';

typedef Profile = JsonMap<String>;

class StorageService {
  static Future<Box> get _profileBox => Hive.openBox('profile');
  static Future<Box> get _prefBox => Hive.openBox('preferences');
  static Future<Box> get _bookingsBox => Hive.openBox('bookings');

  //BOOKINGS

  static Future<List<BookingConfirmation>> bookingList() async =>
      (await _bookingsBox)
          .values
          .map((map) {
            try {
              final jMap =
                  (map as Map).map((key, value) => MapEntry("$key", value));
              return BookingConfirmation.fromMap(jMap);
            } catch (e) {
              logger.w("could not parse booking: $map exception: $e");
              return null;
            }
          })
          .whereType<BookingConfirmation>()
          .sorted((a, b) => (a.starttime ?? 0).compareTo(b.starttime ?? 0));

  static Future<int> bookingAdd(BookingConfirmation conf) async =>
      await (await _bookingsBox).add(conf.map);

  static Future<void> bookingDelete(String id) async =>
      await (await _bookingsBox).delete(id);

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

// SETTINGS
  static Future<Preferences> getPreferences() async {
    try {
      return Preferences.fromMap(
          await (await _prefBox).toMap().map((k, v) => MapEntry("$k", v)));
    } catch (e) {
      logger.t("could not parse saved preferences", error: e);
      return const Preferences();
    }
  }

  static Future<void> setPreferences(Preferences preferences) async =>
      await (await _prefBox).putAll(preferences.map);
}
