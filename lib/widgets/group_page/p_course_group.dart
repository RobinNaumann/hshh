import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hshh/cubits/c_group_info.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/tri/tri_cubit.dart';
import 'package:hshh/widgets/group_page/course_list/v_course_list.dart';
import 'package:hshh/widgets/group_page/v_group_description.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../util/sliver_appbar_title.dart';

class CourseGroupPage extends StatelessWidget {
  final CourseGroup group;

  const CourseGroupPage({super.key, required this.group});

  Widget _appBarImage(BuildContext c) => SliverAppBar(
        pinned: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.white),
          child: IconButton(
              onPressed: () => Navigator.of(c).maybePop(),
              icon: const Icon(LucideIcons.chevronLeft)),
        ),
        collapsedHeight: 85,
        title: InvisibleExpandedHeader(
          child: Text(
            group.name,
            style: GoogleFonts.calistoga(),
          ),
        ),
        expandedHeight: 300.0,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              //color: Theme.of(c).colorScheme.secondaryContainer,
              margin: const EdgeInsets.only(bottom: 2),
              child: FlexibleSpaceBar(
                //title: Text('SliverAppBar'),
                background: GroupInfoCubit.builder(
                  onLoading: (_) => const SizedBox.shrink(),
                  onError: errorView,
                  onData: (_, groupInfo) => FadeInImage.memoryNetwork(
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    placeholder: kTransparentImage,
                    fadeInDuration: const Duration(milliseconds: 200),
                    image: groupInfo.imageURL.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
    return GroupInfoCubit.provider(
      cubit: GroupInfoCubit(group.name),
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          _appBarImage(context),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(group.name, style: GoogleFonts.calistoga(fontSize: 25)),
                const GroupDescriptionView(),
                const SizedBox(height: 20),
                GroupInfoCubit.builder(
                    small: true,
                    onData: (c, groupInfo) => CourseList(
                        courses: group.courses, groupInfo: groupInfo))
              ],
            ),
          ))
        ],
        //...group.courses.map((e) => Text(e.courseName)).toList()
      )),
    );
  }
}

class MeasurementView extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    assert(child != null);
    child!.layout(const BoxConstraints(), parentUsesSize: true);
    size = child!.size;
  }

  @override
  void debugAssertDoesMeetConstraints() => true;
}

Size _measureWidget(Widget widget) {
  final PipelineOwner pipelineOwner = PipelineOwner();
  final MeasurementView rootView = pipelineOwner.rootNode = MeasurementView();
  final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());
  final RenderObjectToWidgetElement<RenderBox> element =
      RenderObjectToWidgetAdapter<RenderBox>(
    container: rootView,
    debugShortDescription: '[root]',
    child: widget,
  ).attachToRenderTree(buildOwner);
  try {
    rootView.scheduleInitialLayout();
    pipelineOwner.flushLayout();
    return rootView.size;
  } finally {
    // Clean up.
    element.update(RenderObjectToWidgetAdapter<RenderBox>(container: rootView));
    buildOwner.finalizeTree();
  }
}
