import 'package:flutter/material.dart';
import 'package:hshh/bits/c_courses.dart';
import 'package:hshh/bits/c_filter.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

import 'v_group_snippet.dart';

class GroupList extends StatelessWidget {
  final bool filtered;
  const GroupList({super.key, this.filtered = true});

  Widget _list(List<CourseGroup> groups) => Column(
      children: groups.map<Widget>((g) => GroupSnippet(group: g)).spaced());

  @override
  Widget build(BuildContext context) {
    return CoursesBit.builder(
        onLoading: triLoadingView,
        onError: triErrorView,
        onData: (cubit, data) => filtered
            ? FilterBit.builder(
                onData: (_, filter) => _list(filter.filter(data.groups)))
            : _list(data.groups));
  }
}
