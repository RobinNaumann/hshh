import 'package:flutter_html/flutter_html.dart';

import '../../bits/c_booking_data.dart';
import '../../util/elbe_ui/elbe.dart';

class BookingOfferView extends StatelessWidget {
  const BookingOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    return BookingDataBit.builder(
        onData: (cubit, data) => Card(
            color: Colors.white,
            child: Html.fromElement(documentElement: data.offerHtml, style: {
              "*": Style(color: Colors.black),
              ".bs_form_entext": Style(
                display: Display.none,
              ),
              ".bs_form_sp2": Style(
                  fontWeight: FontWeight.bold,
                  margin: Margins.only(bottom: 10)),
              "NONE#bs_ag_name": Style(fontSize: FontSize.larger)
            })));
  }
}
