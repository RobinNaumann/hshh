import 'package:hshh/services/s_storage.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
export 'package:hshh/services/s_storage.dart';

typedef Profiles = Map<int, Profile>;

class ProfilesBit extends TriBit<Profiles> {
  static const builder = TriBuilder<Profiles, ProfilesBit>.make;

  ProfilesBit() : super(() => StorageService.profileList());

  void delete(int key) async {
    await StorageService.profileDelete(key);
    reload(silent: true);
  }

  void set(int? key, Profile p) async {
    await StorageService.profileSet(key, p);
    reload(silent: true);
  }
}
