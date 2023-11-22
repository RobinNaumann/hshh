import 'package:hshh/bits/c_group_info.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/widgets/group_page/course_list/v_course_list.dart';
import 'package:hshh/widgets/group_page/v_group_description.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/elbe_ui/elbe.dart';
import '../../util/tri/tribit/tribit.dart';

class CourseGroupPage extends StatelessWidget {
  final CourseGroup group;

  const CourseGroupPage({super.key, required this.group});

  Widget _webLink(Uri? link) => IconButton.integrated(
      icon: Icons.externalLink,
      onTap: link != null ? () => launchUrl(link) : null);

  @override
  Widget build(BuildContext context) {
    return TriProvider(
      create: (_) => GroupInfoBit(group.name),
      child: HeroScaffold(
          leadingIcon: const LeadingIcon.back(),
          title: group.name,
          hero: GroupInfoBit.builder(
            onLoading: (_) => const SizedBox.shrink(),
            onError: triErrorView,
            onData: (_, groupInfo) => groupInfo.imageURL == null
                ? Spaced.zero
                : FadeInImage.memoryNetwork(
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    placeholder: kTransparentImage,
                    imageErrorBuilder: (_, __, ___) => const Spaced(),
                    fadeInDuration: const Duration(milliseconds: 200),
                    image: groupInfo.imageURL.toString(),
                    fit: BoxFit.cover,
                  ),
          ),
          actions: [
            GroupInfoBit.builder(
                onLoading: (_) => _webLink(null),
                onError: (_, __) => _webLink(null),
                onData: (_, d) => _webLink(d.webLink))
          ],
          body: Padded.symmetric(
            horizontal: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text.h3(group.name),
                const GroupDescriptionView(),
                const SizedBox(height: 20),
                GroupInfoBit.builder(
                    small: true,
                    onData: (c, groupInfo) => CourseList(
                        courses: group.courses, groupInfo: groupInfo))
              ],
            ),

            //...group.courses.map((e) => Text(e.courseName)).toList()
          )),
    );
  }
}
