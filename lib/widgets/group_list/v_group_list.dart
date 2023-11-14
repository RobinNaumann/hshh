import 'package:flutter/material.dart';
import 'package:hshh/cubits/c_courses.dart';
import 'package:hshh/cubits/c_filter.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tri/tri_cubit.dart';

import 'v_group_snippet.dart';

class GroupList extends StatelessWidget {
  final bool filtered;
  const GroupList({super.key, this.filtered = true});

  Widget _list(List<CourseGroup> groups) => Column(
      children: groups.map<Widget>((g) => GroupSnippet(group: g)).spaced());

  @override
  Widget build(BuildContext context) {
    return CoursesCubit.builder(
        onLoading: loadingView,
        onError: errorView,
        onData: (cubit, data) => filtered
            ? FilterCubit.builder(
                onData: (_, filter) => _list(filter.filter(data.groups)))
            : _list(data.groups));
  }
}
