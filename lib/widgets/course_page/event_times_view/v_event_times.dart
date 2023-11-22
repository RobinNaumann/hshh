import 'package:hshh/bits/c_event_times.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/models/m_group_info.dart';
import 'package:hshh/services/s_group_info.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
import 'package:hshh/widgets/course_page/event_times_view/v_event_time_snippet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../bits/c_group_info.dart';
import '../../../util/elbe_ui/elbe.dart';

class EventTimesView extends StatelessWidget {
  final bool isFree;
  final Course course;
  const EventTimesView({super.key, required this.course, required this.isFree});

  @override
  Widget build(BuildContext context) {
    return GroupInfoBit.builder(
        onLoading: (_) => const Spaced(),
        onData: (cubit, data) {
          if (!isFree) return _NoTimesWidget.cost(data.webLink);
          final c = data.course(course.id);

          return c == null
              ? _NoTimesWidget.notFound(data.webLink)
              : _EventTimesView(
                  key: Key(c.bookingId),
                  course: course,
                  info: c,
                  groupInfo: data);
        });
  }
}

class _EventTimesView extends StatelessWidget {
  final GroupInfo groupInfo;
  final Course course;
  final CourseInfo info;
  const _EventTimesView(
      {super.key,
      required this.course,
      required this.info,
      required this.groupInfo});

  EventTimesBit _make(BuildContext _) => EventTimesBit(
      groupId: groupInfo.webLink.toString(),
      bookingId: info.bookingId,
      bsCode: groupInfo.bsCode);

  @override
  Widget build(BuildContext context) {
    return TriProvider(
        key: const Key("FIXED"),
        create: _make,
        child: EventTimesBit.builder(
            onLoading: triLoadingView,
            onError: triErrorView,
            onData: (_, data) => data.times.isEmpty
                ? _NoTimesWidget.notFound(
                    GroupInfoService.getCourseLink(info.groupId))
                : Column(
                    children: data.times
                        .listMap((e) =>
                            EventTimeSnippet(course: course, eventTime: e))
                        .spaced(),
                  )));
  }
}

class _NoTimesWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Uri link;
  const _NoTimesWidget(
      {required this.icon, required this.label, required this.link});

  const _NoTimesWidget.notFound(this.link)
      : icon = Icons.searchX,
        label = "Wir konnten keine Termine finden. "
            "Prüfe die Beschreibung oder öffne die Website.";

  const _NoTimesWidget.cost(this.link)
      : icon = Icons.coins,
        label = "Zahlungen können nicht über die App getätigt werden. "
            "Öffne für diesen Kurs bitte die Website.";

  @override
  Widget build(BuildContext context) {
    return Padded.only(
        top: 1,
        child: Column(
            children: [
          Icon(icon),
          Text(
            label,
            textAlign: TextAlign.center,
          ),
          Button.action(
              icon: Icons.externalLink,
              label: "Website öffnen",
              onTap: () => launchUrl(link))
        ].spaced()));
  }
}
