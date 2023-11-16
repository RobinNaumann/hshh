import 'package:hshh/cubits/c_event_times.dart';
import 'package:hshh/models/m_group_info.dart';
import 'package:hshh/services/s_group_info.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tri/tri_cubit.dart';
import 'package:hshh/widgets/course_page/event_times_view/v_event_time_snippet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cubits/c_group_info.dart';
import '../../../util/elbe_ui/elbe.dart';

class EventTimesView extends StatelessWidget {
  final bool isFree;
  final String courseId;
  EventTimesView({super.key, required this.courseId, required this.isFree});

  @override
  Widget build(BuildContext context) {
    print("BUILD TIMESVIEW");
    return GroupInfoCubit.builder(
        key: Key("SUPER"),
        onLoading: (_) => const Spaced(),
        onData: (cubit, data) {
          if (!isFree) return _NoTimesWidget.cost(data.webLink);
          final c = data.course(courseId);

          print("DATA ${c?.bookingId}");

          return c == null
              ? _NoTimesWidget.notFound(data.webLink)
              : _EventTimesView(key: Key("super"), c: c, bsCode: "");
        });
  }
}

class _EventTimesView extends StatelessWidget {
  final CourseInfo c;
  final String bsCode;
  const _EventTimesView({super.key, required this.c, required this.bsCode});

  EventTimesCubit _make(BuildContext _) => EventTimesCubit(
      groupId: c.groupId, bookingId: c.bookingId, bsCode: bsCode);

  @override
  Widget build(BuildContext context) {
    return TriProvider(
        key: const Key("super"),
        cubit: _make,
        child: EventTimesCubit.builder(
            onLoading: loadingView,
            onError: errorView,
            onData: (_, data) => data.times.isEmpty
                ? _NoTimesWidget.notFound(
                    GroupInfoService.getCourseLink(c.groupId))
                : Column(
                    children: data.times
                        .listMap((e) => EventTimeSnippet(eventTime: e))
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
