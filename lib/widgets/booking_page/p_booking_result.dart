import 'package:hshh/bits/c_book.dart';
import 'package:hshh/services/s_booking.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
import 'package:hshh/widgets/favorites/p_bookings.dart';
import 'package:hshh/widgets/util/p_web.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookingResultPage extends StatelessWidget {
  final Confirmation confirmation;
  final BookingReqData data;
  const BookingResultPage(
      {super.key, required this.confirmation, required this.data});

  Widget _base({bool closable = true, required Widget child}) => Scaffold(
      leadingIcon: closable ? const LeadingIcon.back() : null,
      title: "Buchung",
      body: child);

  @override
  Widget build(BuildContext context) {
    return TriProvider(
      create: (_) => BookBit(data: data, confirmation: confirmation),
      child: BookBit.builder(
          onError: (b, e) => _base(child: triErrorView(b, e)),
          onLoading: (b) => _base(child: triLoadingView(b)),
          onData: (cubit, res) => res.confirmation != null
              ? _base(
                  closable: res.confirmation == null,
                  child: Padded.all(
                      child: Column(
                    children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.checkCircle2,
                                  style: TypeStyles.h3,
                                  color: ColorTheme.of(context)
                                      .activeScheme
                                      .majorAlertSuccess
                                      .neutral,
                                ),
                                const Text("Buchung\nerfolgreich",
                                    style: TypeStyles.h3,
                                    textAlign: TextAlign.center),
                              ].spaced())),
                      Button.minor(
                          label: "schließen",
                          onTap: () {
                            final nav = Navigator.of(context);
                            nav.popUntil((r) => r.isFirst);
                            pushPage(context, const BookingsPage());
                          })
                    ],
                  )))
              : HtmlPage(
                  title: "Nachricht",
                  html:
                      "<style>body{background-color: transparent !important} #btn_cancel{display:none} </style> ${res.htmlMessage!}",
                  baseUrl: "https://buchung.hochschulsport-hamburg.de/",
                )),
    );
  }
}
