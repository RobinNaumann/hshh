import 'dart:developer';

import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/models/m_booking_confirmation.dart';
import 'package:hshh/models/m_booking_data.dart';
import 'package:hshh/models/m_data.dart';
import 'package:hshh/models/m_event_time.dart';
import 'package:hshh/services/d_institutions.dart';
import 'package:hshh/util/elbe_ui/src/util/unix_date.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/util/tools.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

import '../models/m_course.dart';
import '../util/api_tools.dart';

const apiHeaders = {
  "Origin": "https://buchung.hochschulsport-hamburg.de",
  "cache-control": "max-age=0",
  "content-type": "application/x-www-form-urlencoded",
  "Referrer-Policy": "strict-origin-when-cross-origin",
  "User-Agent":
      "Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/70.0"
};

const profileOrder = [
  "vorname",
  "name",
  "strasse",
  "ort",
  "statusorig",
  "matnr",
  "mitnr",
  "email",
  "telefon"
];

class BookingResponse {
  final BookingConfirmation? confirmation;
  final String? htmlMessage;

  const BookingResponse.valid(this.confirmation) : htmlMessage = null;
  const BookingResponse.message(this.htmlMessage) : confirmation = null;
}

class Confirmation extends DataModel {
  final String doc;
  final Element offer;
  final Element profile;
  final String formdata;

  const Confirmation(
      {required this.doc,
      required this.offer,
      required this.profile,
      required this.formdata});

  @override
  JsonMap get map => {
        "doc": doc,
        "offer": offer,
        "profile": profile,
        "formdata": formdata,
      };
}

class BookingReqData {
  final String sessionId;
  final String dateId;
  final Profile profile;
  final Course course;
  final EventTime time;

  const BookingReqData(
      {required this.sessionId,
      required this.dateId,
      required this.profile,
      required this.course,
      required this.time});
}

class CourseBooking {
  final String courseName;
  final String groupName;
  final DateTime start;
  final String bookingId;

  const CourseBooking(
      {required this.courseName,
      required this.groupName,
      required this.start,
      required this.bookingId});
}

class BookingService {
  static const confirmDelay = Duration(seconds: 6);

  static final _uri =
      Uri.https('buchung.hochschulsport-hamburg.de', '/cgi/anmeldung.fcgi');

  static Future<BookingData> data(String dateId, String sessionId) async {
    final html = parseHTML((await apiPost(
            uri: _uri,
            headers: {...apiHeaders, 'Referer': _uri.toString()},
            body: {"fid": sessionId, dateId: "buchen"}))
        .body);

    return BookingData(
        offer: _getOffer(html),
        offerHtml: html.getElementById("bs_ag")!,
        inputFields: _getFields(html),
        institutions: Institution.list);
  }

  static Future<Confirmation> confirm({required BookingReqData data}) async {
    await Future.delayed(confirmDelay);
    final res = await _getConfirmPage(_makeBody(data, null));
    final dom = parseHTML(res.body);
    return Confirmation(
        doc: res.body,
        offer: dom.getElementById("bs_ag")!,
        profile: dom.getElementById("bs_form_main")!,
        formdata: dom
            .getElementsByTagName("input")
            .firstWhere((e) =>
                e.attributes.containsKey("name") &&
                e.attributes.containsValue("_formdata"))
            .attributes["value"]!);
  }

  static Future<BookingResponse> book(
      {required Confirmation confirmation,
      required BookingReqData data}) async {
    final res = await _book(_uri, {...apiHeaders, "Referer": _uri.toString()},
        _makeBody(data, confirmation.formdata));

    final red = res.$1; // the redirect uri

    if (red != null && red.contains("Bestaetigung_")) {
      final bookingId =
          red.split("Bestaetigung_").last.replaceMulti([".html", ".pdf"]);
      return BookingResponse.valid(BookingConfirmation(
          groupName: data.course.groupName,
          courseName: data.course.courseName,
          starttime: data.time.start.asUnixMs,
          endtime: data.time.end.asUnixMs,
          profileEmail: data.profile.get("email")!,
          profileName: data.profile.get("vorname"),
          profileInst: data.profile.get("statusorig"),
          bookingId: bookingId,
          formdataId: confirmation.formdata));
    }

    return BookingResponse.message(res.$2!);
  }

  static JsonMap<String> _makeBody(BookingReqData data, String? formdata) {
    final end = formdata != null;

    return {
      "fid": data.sessionId,
      if (end) "Phase": "final",
      "Termin": data.dateId.split("_").last.trim(),
      if (!end) ...{"pw_email": "", "pw_pwd_${data.sessionId}": ""},
      if (end) ...{"tnbed": "1 "},
      "sex": "X",
      ..._sortProfile(data.profile),
      if (!end) ...{"newsletter": "", "tnbed": "1"},
      if (end) ...{
        "preis_anz": "0,00 EUR",
        "_formdata": formdata,
        "pw_newpw_${data.sessionId}": "",
      },
    };
  }

  static Future<Response> _getConfirmPage(JsonMap<String> body) async {
    final res = await apiPost(
        uri: _uri,
        headers: {
          ...apiHeaders,
          "Referer": _uri.toString(),
        },
        body: body);

    log(res.body);
    return res;
  }

  static Map<String, String> _getOffer(Document d) {
    Map<String, String> res = {};

    final rows =
        d.getElementById("bs_ag")!.getElementsByClassName("bs_form_row");

    for (final row in rows) {
      try {
        final k = row.getElementsByClassName("bs_form_sp1").first.text;
        final v = row.getElementsByClassName("bs_form_sp2").first.text;
        res[k] = v;
      } catch (e) {
        logger.t("did not understand row $row in booking form");
      }
    }
    return res;
  }

  static List<InputField> _getFields(Document d) {
    final List<InputField> fields = [];
    final rows =
        d.getElementById("bs_kl_anm")!.getElementsByClassName("bs_form_row");
    for (final r in rows) {
      try {
        final input = r.getElementsByClassName("bs_form_field").first;
        String id = input.attributes["name"]!;
        if (fields.indexWhere((e) => e.id == id) >= 0) continue;

        // get name
        final label = input.parent?.parent
            ?.getElementsByTagName("label")
            .firstOrNull
            ?.text
            .replaceAll("*", "")
            .replaceAll(":", "");

        fields.add(InputField(id: id, label: label ?? id));
      } catch (e) {
        logger.t("could not parse booking form field");
      }
    }
    return fields;
  }

  static JsonMap<String> _sortProfile(Profile p) {
    final JsonMap<String> res = {};
    for (final k in profileOrder) {
      if (p.containsKey(k)) {
        res[k] = p[k] ?? "";
      }
    }
    return res;
  }

  static Future<(String? url, String? http)> _book(
      Uri uri, JsonMap<String> headers, dynamic body) async {
    http.Request req = http.Request("Post", uri)
      ..bodyFields = body
      ..headers.addAll(headers)
      ..followRedirects = false;

    final r = await http.Client().send(req);
    final res = await http.Response.fromStream(r);

    return (res.headers['location'], res.resOrThrow().body);
  }

  static Future<String> getConfirmation(String bookingId, String email) async {
    final client = http.Client();
    final link =
        "https://buchung.hochschulsport-hamburg.de/cgi/anmeldung.fcgi/Bestaetigung_$bookingId.html";

    var redirects = 0;
    http.Response? res;

    while (redirects == 0 ||
        ((res?.statusCode ?? 0) >= 300 && (res?.statusCode ?? 0) < 400)) {
      final uri = Uri.parse(redirects == 0 ? link : res!.headers["location"]!);

      http.Request req = http.Request(redirects == 0 ? "POST" : "GET", uri)
        ..headers.addAll({...apiHeaders, "referer": link});
      if (redirects == 0) {
        req.bodyFields = {"fid": "", "email": email};
      }
      final r = await http.Response.fromStream(await client.send(req));

      print("${r.statusCode} $uri ${r.body}");
      res = r;
      redirects++;
    }
    client.close();
    return res!.resOrThrow().body;
  }
}
