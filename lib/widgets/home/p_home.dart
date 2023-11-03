import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hshh/util/sliver_appbar_title.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/group_list/v_group_list.dart';
import 'package:hshh/widgets/profiles/profile_list/p_profile_list.dart';
import 'package:hshh/widgets/profiles/profile_edit/p_profile_edit.dart';
import 'package:lucide_icons/lucide_icons.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _hero(BuildContext c) => SliverAppBar(
        actions: [
          IconButton(
              onPressed: () => pushPage(c, const ProfileListPage()),
              icon: const Icon(LucideIcons.users))
        ],
        pinned: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: InvisibleExpandedHeader(
            child: Text("HSHH", style: GoogleFonts.calistoga())),
        expandedHeight: 300.0,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.grey.shade200,
              margin: const EdgeInsets.only(bottom: 2),
              child: FlexibleSpaceBar(
                  //title: Text('SliverAppBar'),
                  background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                      "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4476ed87793337.5dc2f046e46bc.gif",
                      fit: BoxFit.cover,
                      alignment: Alignment.centerLeft),
                  Center(
                    child: Text(
                      "HsHH",
                      style: GoogleFonts.calistoga(
                          fontSize: 120, color: Colors.white),
                    ),
                  ),
                ],
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 22,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    color: Colors.white),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _hero(context),
        const SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GroupList()))
      ],
      //...group.courses.map((e) => Text(e.courseName)).toList()
    ));
  }
}
