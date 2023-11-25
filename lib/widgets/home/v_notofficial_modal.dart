import 'package:hshh/bits/c_preferences.dart';
import 'package:hshh/services/s_devlog.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

import '../../util/elbe_ui/elbe.dart';

class NotOfficialLoader extends StatelessWidget {
  final Widget child;
  const NotOfficialLoader({super.key, required this.child});

  @override
  Widget build(BuildContext context) => PreferencesBit.notifier(
      onData: (bit, data) {
        if (data.launchMessageAccepted) return;
        showModalBottomSheet(
            enableDrag: false,
            context: context,
            isDismissible: false,
            builder: (_) => const NotOfficialModal());
      },
      child: child);
}

class NotOfficialModal extends StatelessWidget {
  const NotOfficialModal({super.key});

  _close(BuildContext context, bool consent) {
    if (consent) DevLog.giveExtendedConsent();

    popPage(context);
    context.bit<PreferencesBit>().setLaunchMessageAccepted(true);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      scheme: ColorSchemes.secondary,
      padding: const RemInsets.all(2),
      border: const Border(
          pixelWidth: 0,
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text.h3("Moin :)"),
          const Text(
              "hier ist Robin. Die letzten Monate hab' ich diese App entwickelt"
              " um es einfacher zu machen, Kurse für den universitären Sport in"
              " Hamburg zu buchen. \nDiese App ist ein privates Projekt und in"
              " keiner Weise mit dem 'Hochschulsport Hamburg' assoziiert."),
          /*const Text.bodyS("Um die App zu verbessern würde ich gerne"
              " pseudonymisierte Daten sowie Fehler & Abstürze via Countly auswerten. "
              "Ist das okay? Keine Angst, die App ist werbefrei :)"),*/
          Column(children: [
            /*Button.integrated(
                label: "nein", onTap: () => _close(context, false)),*/
            Button.major(
                icon: Icons.check,
                label: "okay",
                onTap: () => _close(context, true)),
          ]),
        ].spaced(),
      ),
    );
  }
}
