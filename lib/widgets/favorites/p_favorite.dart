import 'package:collection/collection.dart';
import 'package:hshh/bits/c_courses.dart';
import 'package:hshh/bits/c_favorites.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/widgets/group_page/course_list/v_course_snippet.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        leadingIcon: const LeadingIcon.back(),
        title: "Favoriten",
        body: Padded.all(
            child: CoursesBit.builder(
                onData: (_, groups) =>
                    FavoritesBit.builder(onData: (cubit, favs) {
                      final favsWidgets = <Widget>[];
                      for (final fav in favs) {
                        for (final group in groups.groups) {
                          final c = group.courses
                              .firstWhereOrNull((c) => c.id == fav);
                          if (c == null) continue;
                          favsWidgets.add(
                              CourseSnippet(course: c, showGroupname: true));
                        }
                      }
                      return ListView(children: favsWidgets.spaced());
                    }))));
  }
}
