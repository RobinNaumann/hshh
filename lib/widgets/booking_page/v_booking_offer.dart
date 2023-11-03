import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hshh/util/tools.dart';

import '../../cubits/c_booking_data.dart';

class BookingOfferView extends StatelessWidget {
  const BookingOfferView({super.key});

  @override
  Widget build(BuildContext context) {
    return BookingDataCubit.builder(
        small: true,
        onData: (cubit, data) => Container(
            padding: const EdgeInsets.all(10),
            decoration: boxDeco,
            child: Html.fromElement(documentElement: data.offerHtml, style: {
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
