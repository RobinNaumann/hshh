import 'package:flutter/material.dart';
import 'package:hshh/widgets/profiles/profile_list/v_profile_list.dart';

class ProfileListPage extends StatelessWidget {
  const ProfileListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personen")),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: ProfileListView(),
        )),
      ),
    );
  }
}
