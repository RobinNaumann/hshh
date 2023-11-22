import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bits/c_group_info.dart';
import '../../services/s_group_info.dart';

class GroupDescriptionView extends StatelessWidget {
  const GroupDescriptionView({super.key});

  Widget _maybeExpand(int chars, Widget child) {
    double frac = 300 / chars;

    return frac >= 1
        ? child
        : ExpandChild(collapsedVisibilityFactor: frac, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return GroupInfoBit.builder(
        onLoading: triLoadingView,
        onError: triErrorView,
        onData: (_, groupInfo) => _maybeExpand(
            groupInfo.description.length,
            Html(
                data: groupInfo.description,
                style: {"body": Style(margin: Margins.all(0))},
                onLinkTap: (url, _, __) => url == null
                    ? null
                    : launchUrl(GroupInfoService.fileUrl(url)))));
  }
}
