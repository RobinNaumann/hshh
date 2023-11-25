import 'package:hshh/models/m_event_time.dart';
import 'package:hshh/services/s_booking.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tools.dart';
import 'package:html/parser.dart';

import '../util/api_tools.dart';

class EventTimesSession {
  final String sessionId;
  final List<EventTime> times;

  const EventTimesSession({required this.sessionId, required this.times});
}

class EventTimesService {
  static final _uri =
      Uri.https('buchung.hochschulsport-hamburg.de', '/cgi/anmeldung.fcgi');
//TODO: hack mit aktuellem Zeitraum
  static Future<EventTimesSession> getTimes(
      String groupLink, String bsCode, String bookingId) async {
    final html = parseHTML((await apiPost(uri: _uri, headers: {
      ...apiHeaders,
      "Referer":
          groupLink.replaceAll("aktueller_zeitraum", "Wintersemester_2023_2024")
    }, body: {
      "BS_Code": bsCode,
      bookingId: "Vormerkliste"
    }))
        .body);
    final bs = html.getElementsByClassName("bs_form_row");

    final List<EventTime> times = [];

    for (final e in bs) {
      try {
        if (e.children.first.localName != "label") continue;
        // get the DOM elements
        final date = e.getElementsByClassName("bs_text_bold").first.text;
        final time = e.getElementsByClassName("bs_time").first.text.split("-");
        final actions = e.getElementsByClassName("bs_right").first;

        // parse the date objects
        final day = _parseDay(date);
        final start = _parseTime(day, time[0]);
        final end = _parseTime(day, time[1]);

        // get state
        final bkDom = actions.getElementsByClassName("buchen");
        final wlDom = actions.getElementsByClassName("warteliste");

        //final bookingMode = bkDom.isNotEmpty;

        // add element to results list
        times.add(
          EventTime(
              start: start,
              end: end,
              state: bkDom.isNotEmpty
                  ? EventTimeState.bookable
                  : (wlDom.isNotEmpty
                      ? EventTimeState.waitinglist
                      : EventTimeState.closed),
              bookingId: (bkDom + wlDom).firstOrNull?.attributes["name"]),
        );
      } catch (e) {
        logger.t("could not parse time entry");
      }
    }

    // get session id
    final sessionId = html
        .getElementsByTagName("input")
        .firstWhere((e) => e.attributes.containsValue("fid"))
        .attributes["value"]!;

    return EventTimesSession(sessionId: sessionId, times: times);
  }

  static DateTime _parseDay(String day) {
    final parts = day.split(".").listMap(int.parse);
    return DateTime(parts[2], parts[1], parts[0]);
  }

  static DateTime _parseTime(DateTime day, String time) {
    final parts = time.split(".").listMap(int.parse);
    return day.copyWith(hour: parts[0], minute: parts[1]);
  }
}
