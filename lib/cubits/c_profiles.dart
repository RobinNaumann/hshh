import 'package:hshh/services/s_storage.dart';
export 'package:hshh/services/s_storage.dart';

import '../util/tri/tri_cubit.dart';

typedef Profiles = Map<int, Profile>;

class ProfilesCubit extends TriCubit<Profiles> {
  static const provider = TriCubit.provider<ProfilesCubit>;
  static const builder = TriCubit.builder<ProfilesCubit, Profiles>;

  ProfilesCubit() : super(() => StorageService.profileList());

  void delete(int key) async {
    await StorageService.profileDelete(key);
    reload(silent: true);
  }

  void set(int? key, Profile p) async {
    await StorageService.profileSet(key, p);
    reload(silent: true);
  }
}
