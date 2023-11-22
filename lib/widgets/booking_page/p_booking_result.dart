import 'package:hshh/bits/c_book.dart';
import 'package:hshh/services/s_booking.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
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
                                Text("Buchung\nerfolgreich",
                                    style: TypeStyles.h3,
                                    textAlign: TextAlign.center),
                              ].spaced())),
                      Button.minor(
                        label: "schließen",
                        onTap: () =>
                            Navigator.of(context).popUntil((r) => r.isFirst),
                      )
                    ],
                  )))
              : _WebPage(page: res.htmlMessage!)),
    );
  }
}

class _WebPage extends StatelessWidget {
  final WebViewController ctrl = WebViewController();
  _WebPage({required String page}) {
    ctrl.loadHtmlString(
        "<style>body{background-color: transparent !important} #btn_cancel{display:none} </style> $page",
        baseUrl: "https://buchung.hochschulsport-hamburg.de/");
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: ctrl);
  }
}
