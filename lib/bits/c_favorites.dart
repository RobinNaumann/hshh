import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

class FavoritesBit extends TriBit<List<String>> {
  static const builder = TriBuilder<List<String>, FavoritesBit>.make;

  FavoritesBit() : super(() => StorageService.favoriteList());

  bool isFavorite(String id) =>
      state.whenOrNull(onData: (l) => l.contains(id)) ?? false;

  void modify(String id, bool add) => state.whenOrNull(onData: (l) async {
        await (add
            ? StorageService.favoriteAdd
            : StorageService.favoriteRemove)(id);

        reload(silent: true);
      });
}
