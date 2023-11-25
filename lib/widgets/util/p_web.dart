import 'package:flutter_html/flutter_html.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/elbe_ui/elbe.dart';

class WebPage extends StatelessWidget {
  final Uri uri;
  final JsonMap<String> headers;
  final String title;
  const WebPage(
      {super.key,
      required this.uri,
      required this.title,
      this.headers = const {}});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      leadingIcon: const LeadingIcon.close(),
      title: title,
      body: WebViewWidget(
          controller: WebViewController()..loadRequest(uri, headers: headers)),
    );
  }
}

class HtmlPage extends StatelessWidget {
  final WebViewController ctrl = WebViewController();

  final String html;
  final String? baseUrl;
  final String title;
  HtmlPage({super.key, this.baseUrl, required this.title, required this.html}) {
    ctrl.loadHtmlString(html, baseUrl: baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      leadingIcon: const LeadingIcon.close(),
      title: title,
      body: WebViewWidget(controller: ctrl),
    );
  }
}


//https://buchung.hochschulsport-hamburg.de/cgi/anmeldung.fcgi/Bestaetigung_4ce8e19b77fe066eb9cbdcb6a4f8ceab24183e90.html
//https://buchung.hochschulsport-hamburg.de/cgi/anmeldung.fcgi?id=1367231&bnr=3e320ebe7fa394ec8c1f96d10c00134beceaf7d1