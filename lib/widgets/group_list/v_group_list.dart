import 'package:flutter/material.dart';
import 'package:hshh/cubits/c_courses.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tri/tri_cubit.dart';

import 'v_group_snippet.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return CoursesCubit.builder(
        onLoading: loadingView,
        onError: errorView,
        onData: (cubit, data) => Column(
            children: data.groups
                //.where((e) => e.name.startsWith("Tri"))
                .map<Widget>((g) => GroupSnippet(group: g))
                .spaced()));
  }
}
