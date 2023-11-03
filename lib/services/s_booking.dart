import 'package:hshh/services/d_institutions.dart';
import 'package:hshh/util/tools.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../util/api_tools.dart';

class BookingData {
  final Map<String, String> offer;
  final Element offerHtml;
  final List<InputField> fields;
  final List<Institution> institutions;

  const BookingData(
      {required this.offer,
      required this.offerHtml,
      required this.fields,
      required this.institutions});
}

class InputField {
  final String id;
  final String label;
  final String? type;

  const InputField({required this.id, required this.label, this.type});
}

class BookingService {
  static final _uri =
      Uri.https('buchung.hochschulsport-hamburg.de', '/cgi/anmeldung.fcgi');

  static Future<BookingData> data(String dateId, String sessionId) async {
    final html = parse(await apiPost(uri: _uri, headers: {
      'Referer':
          "https://buchung.hochschulsport-hamburg.de/angebote/Wintersemester_2023_2024/_Hallenfussball.html"
    }, body: {
      "fid": sessionId,
      dateId: "buchen"
    }));

    return BookingData(
        offer: _getOffer(html),
        offerHtml: html.getElementById("bs_ag")!,
        fields: _getFields(html),
        institutions: Institution.list);
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
}
