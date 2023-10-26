import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hshh/util/sliver_appbar_title.dart';
import 'package:hshh/widgets/group_list/group_list_v.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _hero(BuildContext c) => SliverAppBar(
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
                  background: Container(
                color: Colors.grey.shade200,
                child: Center(
                  child: Text(
                    "HSHH",
                    style: GoogleFonts.calistoga(
                        fontSize: 120, color: Colors.grey.shade300),
                  ),
                ),
              )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 22,
                decoration: BoxDecoration(
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
        SliverToBoxAdapter(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GroupList()))
      ],
      //...group.courses.map((e) => Text(e.courseName)).toList()
    ));
  }
}
