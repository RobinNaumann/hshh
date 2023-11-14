import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/favorites/p_favorite.dart';
import 'package:hshh/widgets/group_list/v_group_list.dart';
import 'package:hshh/widgets/home/v_group_filter.dart';
import 'package:hshh/widgets/profiles/profile_list/p_profile_list.dart';
import 'package:hshh/widgets/settings/p_settings.dart';

import '../../util/elbe_ui/elbe.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HeroScaffold(
        title: "HsHH",
        leadingIcon: LeadingIcon(
            icon: Icons.settings, onTap: (c) => pushPage(c, const SettingsPage())),
        actions: [
          IconButton.integrated(
              icon: Icons.heart,
              onTap: () => pushPage(context, const FavoritePage())),
          IconButton.integrated(
            icon: Icons.users2,
            onTap: () => pushPage(context, const ProfileListPage()),
          )
        ],
        hero: Card(
          border: Border.noneRect,
          padding: null,
          scheme: ColorSchemes.inverse,
          color: Colors.transparent,
          child: Stack(fit: StackFit.expand, children: [
            Image.asset("assets/img/biking.webp",
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
                errorBuilder: (_, __, ___) => Spaced.zero),
            const Center(
                child: Text(
              "HsHH",
              color: Colors.white,
              resolvedStyle: TypeStyle(fontFamily: titleFont, fontSize: 105),
            ))
          ]),
        ),
        body: Padded.symmetric(
            horizontal: 1,
            child: Column(
                children: [
              const GroupFilterView(),
              const SingleChildScrollView(child: GroupList())
            ].spaced(amount: 2)))

        //...group.courses.map((e) => Text(e.courseName)).toList()
        );
  }
}
