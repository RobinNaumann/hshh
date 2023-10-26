import 'package:flutter/material.dart';
import 'package:hshh/cubits/courses_cubit.dart';
import 'package:hshh/models/course.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tri/tri_cubit.dart';

import '../../services/courses_service.dart';
import 'group_snippet_v.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return CoursesCubit.builder(
        onLoading: loadingView,
        onError: errorView,
        onData: (cubit, data) => Column(
            children: data.groups
                .map<Widget>((g) => GroupSnippet(group: g))
                .spaced()));
  }
}
