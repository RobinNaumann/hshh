import 'dart:developer';

import 'package:hshh/cubits/c_profiles.dart';
import 'package:hshh/models/m_booking_data.dart';
import 'package:hshh/services/d_institutions.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/util/tools.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../util/api_tools.dart';

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

class Confirmation {
  final String doc;
  final Element offer;
  final Element profile;
  final String formdata;

  const Confirmation(
      {required this.doc,
      required this.offer,
      required this.profile,
      required this.formdata});
}

class BookingReqData {
  final String sessionId;
  final String dateId;
  final Profile profile;

  const BookingReqData(
      {required this.sessionId, required this.dateId, required this.profile});
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
  static final _uri =
      Uri.https('buchung.hochschulsport-hamburg.de', '/cgi/anmeldung.fcgi');

  static Future<BookingData> data(String dateId, String sessionId) async {
    final html = parse(await apiPost(
        uri: _uri,
        headers: {'Referer': "https://buchung.hochschulsport-hamburg.de/"},
        body: {"fid": sessionId, dateId: "buchen"}));

    return BookingData(
        offer: _getOffer(html),
        offerHtml: html.getElementById("bs_ag")!,
        inputFields: _getFields(html),
        institutions: Institution.list);
  }

  static Future<Confirmation> confirm(BookingReqData data) async {
    final res = await _book(data, null);
    final dom = parse(res);
    return Confirmation(
        doc: res,
        offer: dom.getElementById("bs_ag")!,
        profile: dom.getElementById("bs_form_main")!,
        formdata: dom
            .getElementsByTagName("input")
            .firstWhere((e) =>
                e.attributes.containsKey("name") &&
                e.attributes.containsValue("_formdata"))
            .attributes["value"]!);
  }

  static Future<String> book(BookingReqData data, String formdata) =>
      _book(data, formdata);

  static Future<String> _book(BookingReqData data, String? formdata) async {
    final book = formdata != null;

    final formData = {
      "fid": data.sessionId,
      if (book) "Phase": "final",
      "Termin": data.dateId.split("_").last.trim(),
      if (!book) ...{"pw_email": "", "pw_pwd_${data.sessionId}": ""},
      //if (book) ...{"tnbed": "1 "},
      "sex": "X",
      ..._sortProfile(data.profile),
      if (!book) ...{"newsletter": "", "tnbed": "1"},
      if (book) ...{
        "preis_anz": "0,00 EUR",
        "_formdata": formdata,
        "pw_newpw_${data.sessionId}": "",
      },
    };

    final res = await apiPost(
        uri: _uri,
        headers: {
          //"accept":"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
          //"accept-language": "en-GB,en-US;q=0.9,en;q=0.8,de;q=0.7",
          "cache-control": "max-age=0",
          "content-type": "application/x-www-form-urlencoded",
          /*"sec-ch-ua":
              "\"Google Chrome\";v=\"119\", \"Chromium\";v=\"119\", \"Not?A_Brand\";v=\"24\"",
          "sec-ch-ua-mobile": "?0",
          "sec-ch-ua-platform": "\"macOS\"",
          "sec-fetch-dest": "document",
          "sec-fetch-mode": "navigate",
          "sec-fetch-site": "same-origin",
          "sec-fetch-user": "?1",*/
          //"upgrade-insecure-requests": "1",
          "Referer":
              "https://buchung.hochschulsport-hamburg.de/cgi/anmeldung.fcgi",
          "Referrer-Policy": "strict-origin-when-cross-origin",
          "User-Agent":
              "Mozilla/5.0 (Macintosh; Intel Mac OS X x.y; rv:42.0) Gecko/20100101 Firefox/70.0"
        },
        body: formData);

    log(res);
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
}
