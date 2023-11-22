import 'package:hshh/bits/c_favorites.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/tools.dart';

class CourseFavButton extends StatelessWidget {
  final String courseId;
  const CourseFavButton({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return FavoritesBit.builder(
        small: true,
        onData: (cubit, data) {
          bool isFav = cubit.isFavorite(courseId);
          return IconButton.integrated(
              onTap: () {
                cubit.modify(courseId, !isFav);
                showSnackbar(
                    context,
                    isFav
                        ? "von Favoriten entfernt"
                        : "zu Favoriten hinzugefügt");
              },
              icon: isFav
                  ? MaterialIcons.favorite_rounded
                  : MaterialIcons.favorite_border_rounded);
        });
  }
}
