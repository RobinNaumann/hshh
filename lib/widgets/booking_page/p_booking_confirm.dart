import 'package:flutter_html/flutter_html.dart';
import 'package:hshh/bits/c_booking_confirm.dart';
import 'package:hshh/models/m_event_time.dart';
import 'package:hshh/services/s_booking.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
import 'package:hshh/widgets/booking_page/p_booking_result.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/m_course.dart';
import '../../services/s_storage.dart';
import 'p_booking_data.dart';

class BookingConfirmPage extends StatelessWidget {
  static const _lawText =
      "Mit dem Klick auf 'verbindlich buchen' ist ihre Buchung verbindlich "
      "und kostenpflichtig abgeschlossen und Sie sind zur Zahlung des Kursentgelts verpflichtet, ein "
      "Recht auf Widerruf besteht bei unseren Angeboten nicht. \n\n"
      "Die von Ihnen bereitgestellten Daten sind zur Erfüllung des Vertragsverhältnisses erforderlich und werden von uns auf Grundlage der gesetzlichen Bestimmungen verarbeitet, um Ihnen die Teilnahme an unserem Sportangebot zu ermöglichen. Die Übertragung Ihrer Daten erfolgt über verschlüsselte Verbindung.";
  final BookingReqData data;
  const BookingConfirmPage({super.key, required this.data});

  get style => {
        "*": Style(color: Colors.black),
        ".bs_form_infotext, .bs_form_entext, #bs_dserklaerung":
            Style(display: Display.none),
        ".bs_text_big": Style(
            margin: Margins.only(bottom: 20), fontStyle: FontStyle.italic),
        ".bs_form_sp2": Style(
            fontWeight: FontWeight.bold, margin: Margins.only(bottom: 10)),
      };

  @override
  Widget build(BuildContext context) {
    return TriProvider(
        create: (_) => BookingConfBit(data: data),
        child: Scaffold(
          leadingIcon: const LeadingIcon.back(),
          title: "überprüfen",
          body: BookingConfBit.builder(onData: (cubit, conf) {
            return Column(
              children: [
                Expanded(
                    child: Padded.all(
                  child: ListView(
                    clipBehavior: Clip.none,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Html.fromElement(
                            documentElement: conf.offer, style: style),
                      ),
                      Card(
                          color: Colors.white,
                          child: Html.fromElement(
                              documentElement: conf.profile,
                              style: {
                                ...style,
                                ".bs_form_row": Style(display: Display.none),
                                '.bs_form_row[class*=" "]': Style(
                                    display: Display.inline,
                                    padding: HtmlPaddings.only(bottom: 10))
                              })),
                      const Text(_lawText)
                    ].spaced(),
                  ),
                )),
                BookingDataPage.actionBase(
                    child: Button.major(
                        icon: Icons.check,
                        label: "verbindlich buchen",
                        onTap: () {
                          pushPage(
                              context,
                              BookingResultPage(
                                  confirmation: conf, data: data));
                        }))
              ],
            );
          }),
        ));
  }
}
