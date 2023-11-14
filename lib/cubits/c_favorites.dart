import 'package:hshh/cubits/c_profiles.dart';

import '../util/tri/tri_cubit.dart';

class FavoritesCubit extends TriCubit<List<String>> {
  static const provider = TriCubit.provider<FavoritesCubit>;
  static const builder = TriCubit.builder<FavoritesCubit, List<String>>;

  FavoritesCubit() : super(() => StorageService.favoriteList());

  bool isFavorite(String id) =>
      state.whenOrNull(onData: (l) => l.contains(id)) ?? false;

  void modify(String id, bool add) => state.whenOrNull(onData: (l) async {
        await (add
            ? StorageService.favoriteAdd
            : StorageService.favoriteRemove)(id);

        reload(silent: true);
      });
}
