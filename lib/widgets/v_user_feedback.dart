import 'package:hshh/util/tri/tribit/tribit.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../util/elbe_ui/elbe.dart';
import '../util/tools.dart';
import 'util/t_field.dart';

class UserFeedbackView extends StatelessWidget {
  const UserFeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        onTap: () => pushPage(
            context,
            Scaffold(
                leadingIcon: LeadingIcon.close(),
                title: "Feedback",
                body: Padded.all(child: UserFeedback()))),
        border: Border.none,
        style: ColorStyles.minorAlertSuccess,
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(Icons.flaskConical),
            Expanded(
                child: Text(
                    "Dies ist eine frühe Beta-Version. Wenn du Probleme findest oder Vorschläge hast, schreib' mir gerne hier")),
            Icon(Icons.chevronRight)
          ].spaced(amount: 1),
        ));
  }
}

enum _StateType { editing, invalid, sending, error, sent, openedClient }

class UserFeedback extends StatefulWidget {
  const UserFeedback({super.key});

  @override
  State<UserFeedback> createState() => _UserFeedbackState();
}

class _UserFeedbackState extends State<UserFeedback> {
  TextEditingController titleC = TextEditingController();
  TextEditingController descC = TextEditingController();

  _StateType type = _StateType.editing;

  Future<void> _openMailClient(_FeedbackMail mail) async {
    final mailUrl =
        'mailto:${mail.address}?subject=${mail.title}&body=${mail.bodyPlain}';

    await launchUrl(Uri.parse(Uri.encodeFull(mailUrl)));
  }

  Future<void> _send(String title, String description) async {
    _set(_StateType.sending);
    try {
      final pInfo = await PackageInfo.fromPlatform();

      final feedback = _FeedbackMail(
          address: "constorux+hshh@gmail.com",
          title: "HsHH | user feedback",
          description: description,
          software: pInfo.appName,
          softwareEdition: "android",
          softwareVersion: "${pInfo.version}+${pInfo.buildNumber}",
          user: "--",
          date: DateTime.now().toIso8601String());

      _openMailClient(feedback);
      _set(_StateType.openedClient);
    } catch (e) {
      logger.e("could not send mail", error: e);
      _set(_StateType.error);
    }
  }

  void _set(_StateType t) => setState(() => type = t);

  Widget _editing({bool invalid = false}) {
    return ListView(children: [
      TField(
        controller: titleC,
        label: "Titel",
      ),
      const Spaced.vertical(),
      TField(
        controller: descC,
        label: "kurze Beschreibung",
        maxLines: 3,
      ),
      if (invalid)
        Padded.only(
            top: 1,
            child: const Text(
              "Bitte füllen Sie beide Felder aus!",
              variant: TypeVariants.bold,
            )),
      const Spaced.vertical(),
      Button.major(
          icon: Icons.send,
          label: "senden",
          onTap: () {
            if (titleC.text.isEmpty || descC.text.isEmpty) {
              return _set(_StateType.invalid);
            }
            _send(titleC.text, descC.text);
          })
    ]);
  }

  Widget _statusView(
      {required IconData icon,
      required String title,
      required String description,
      required String buttonLabel,
      required VoidCallback onTab}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const Spaced.vertical(),
        Text(
          title,
          style: TypeStyles.bodyL,
          variant: TypeVariants.bold,
          textAlign: TextAlign.center,
        ),
        const Spaced.vertical(),
        Text(description, textAlign: TextAlign.center),
        const Spaced.vertical(),
        Center(child: Button.action(label: buttonLabel, onTap: onTab))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case _StateType.editing:
        return _editing();
      case _StateType.invalid:
        return _editing(invalid: true);
      case _StateType.sending:
        return const Center(child: CircularProgressIndicator.adaptive());
      case _StateType.openedClient:
        return _statusView(
            icon: Icons.check,
            title: "Email Programm geöffnet",
            description: "Bitte sende das Feedback über dein Email-Programm",
            buttonLabel: "neues Feedback",
            onTab: () {
              titleC.clear();
              descC.clear();
              _set(_StateType.editing);
            });
      case _StateType.sent:
        return _statusView(
            icon: Icons.check,
            title: "Feedback gesendet",
            description: "Vielen Dank für dein Feedback.",
            buttonLabel: "neues Feedback",
            onTab: () {
              titleC.clear();
              descC.clear();
              _set(_StateType.editing);
            });

      default:
        return _statusView(
            icon: Icons.alertTriangle,
            title: "Fehler beim Senden",
            description: "Feedback konnte nicht gesendet werden",
            buttonLabel: "zurück",
            onTab: () => _set(_StateType.editing));
    }
  }
}

class _FeedbackMail {
  final String address;
  final String title;
  final String description;
  final String software;
  final String softwareEdition;
  final String softwareVersion;
  final String user;
  final String date;

  const _FeedbackMail(
      {required this.address,
      required this.title,
      required this.description,
      required this.software,
      required this.softwareEdition,
      required this.softwareVersion,
      required this.user,
      required this.date});

  String _sanitize(String userInput) =>
      userInput.replaceAllMapped(RegExp(r'[&<>"/]'), (m) => "#");

  String get bodyHTML => '''
<p>a user as submitted the following feedback:</p>

<div style="display: inline-block; border-radius: 5px; background-color: #007bc033; padding: 12px; margin-bottom: 40px">
    <h4 style="margin:0px">${_sanitize(title)}</h4>
    <p style="margin:0px; margin-top:7px">${_sanitize(description)}</p>
</div>

<h3>information</h3>
<table border="1" cellpadding="1" cellspacing="1" style="height:51px; width:300px">
    <tbody>
        <tr>
            <td>software</td>
            <td>${_sanitize(software)}</td>
        </tr>
        <tr>
            <td>edition</td>
            <td>${_sanitize(softwareEdition)}</td>
        </tr>
        <tr>
            <td>version</td>
            <td>${_sanitize(softwareVersion)}</td>
        </tr>
        <tr>
            <td>date</td>
            <td>${_sanitize(date)}</td>
        </tr>
        <tr>
            <td>user</td>
            <td>${_sanitize(user)}</td>
        </tr>
    </tbody>
</table>

<p>&nbsp;</p>

<i>this mail was automatically generated via the excubia user feedback software</i>
''';

  String get bodyPlain => '''
a user as submitted the following feedback:

${_sanitize(title)}

${_sanitize(description)}


information
-----------------------------
software: ${_sanitize(software)}
edition: ${_sanitize(softwareEdition)}
version: ${_sanitize(softwareVersion)}
date: ${_sanitize(date)}
-----------------------------

this mail was automatically generated via the excubia user feedback software
''';
}
