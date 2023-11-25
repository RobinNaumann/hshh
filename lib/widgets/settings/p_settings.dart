import 'package:hshh/oss_licenses_page.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/util/p_web.dart';

import '../../bits/c_preferences.dart';
import '../../util/elbe_ui/elbe.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Widget _withLove() => Card(
        border: Border.none,
        state: ColorStates.disabled,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.code2),
                    Text.h5("mit"),
                    Icon(Icons.heart)
                  ].spaced(amount: 0.6)),
              const Text.h5("in Altona")
            ].spaced(amount: 0.3)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        title: "Einstellungen",
        leadingIcon: const LeadingIcon.close(),
        body: Padded.all(
            child: PreferencesBit.builder(
          onData: (c, prefs) => ListView(
            clipBehavior: Clip.none,
            children: [
              const Title.h5("Anzeige", topPadded: false),
              ToggleButtons(
                  selected: prefs.themeMode,
                  items: const [
                    MultiToggleItem(
                        key: ColorModes.light, label: "Hell", icon: Icons.sun),
                    MultiToggleItem(
                        key: ColorModes.dark,
                        label: "Dunkel",
                        icon: Icons.moon),
                    MultiToggleItem(key: null, label: "System", icon: Icons.cog)
                  ],
                  onSelect: (v) => c.setColorMode(v)),
              const Title.h5("Informationen"),
              _SettingsButton(
                label: "Open Source Lizenzen",
                onTap: () => pushPage(context, OssLicensesPage()),
              ),
              _SettingsButton(
                label: "Datenschutz",
                onTap: () => pushPage(
                    context,
                    WebPage(
                        title: "Datenschutz",
                        uri: Uri.https("www.hochschulsport.uni-hamburg.de",
                            "/privacypolicy.html"))),
              ),
              _SettingsButton(
                label: "Impressum",
                onTap: () => pushPage(
                    context, HtmlPage(title: "Impressum", html: _impressum)),
              ),
              _withLove()
            ].spaced(),
          ),
        )));
  }
}

class _SettingsButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SettingsButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
        height: 3,
        padding: RemInsets.zero,
        onTap: onTap,
        border: Border.none,
        child: Row(children: [
          Expanded(
              child: Text(
            label,
            variant: TypeVariants.bold,
          )),
          const Icon(Icons.chevronRight)
        ]));
  }
}

const _impressum = """
<div style="font-size: 2rem">
            <h3>Angaben gemäß §5 des TMG</h3><br>
            <i> Die Angaben beziehen sich nur auf die App, jedoch nicht auf den Dienstleister und das Backend/Buchungssystem selbst. Hierfür prüfen Sie bitte <a href="https://www.hochschulsport.uni-hamburg.de/">https://www.hochschulsport.uni-hamburg.de</a></i> 
            <p> Robin Naumann <br>
                Post-Addresse auf Anfrage erhältlich<br>
                91052 Erlangen</p>
            <h3><b>Vertreten durch:</b></h3>
            <p>Sebastian Schroth<br>
                Daniel Ari<br>
                Fatma Ari</p>
            <h3><b>Kontakt:</b></h3>
            <p><b>Email:</b>&nbsp;constorux@gmail.com
            </p>
            <p>Als Diensteanbieter sind wir gemäß § 7 Abs.1 TMG für eigene Inhalte
                auf diesen Seiten nach den allgemeinen Gesetzen verantwortlich. Nach §§ 8 bis 10 TMG sind wir als
                Diensteanbieter jedoch nicht verpflichtet, übermittelte oder gespeicherte fremde Informationen zu
                überwachen oder nach Umständen zu forschen, die auf eine rechtswidrige Tätigkeit hinweisen.
                Verpflichtungen zur Entfernung oder Sperrung der Nutzung von
                Informationen nach den allgemeinen Gesetzen bleiben hiervon unberührt. Eine diesbezügliche Haftung ist
                jedoch erst ab dem Zeitpunkt der Kenntnis einer konkreten Rechtsverletzung möglich. Bei Bekanntwerden
                von entsprechenden Rechtsverletzungen werden wir diese Inhalte umgehend entfernen.</p>
            <h2><b>Haftung für Links</b></h2>
            <p>Unser Angebot enthält Links zu externen Webseiten Dritter, auf deren
                Inhalte wir keinen Einfluss haben. Deshalb können wir für diese fremden Inhalte auch keine Gewähr
                übernehmen. Für die Inhalte der verlinkten Seiten ist stets der jeweilige Anbieter oder Betreiber der
                Seiten verantwortlich. Die verlinkten Seiten wurden zum Zeitpunkt der Verlinkung auf mögliche
                Rechtsverstöße überprüft. Rechtswidrige Inhalte waren zum Zeitpunkt der Verlinkung nicht erkennbar. Eine
                permanente inhaltliche Kontrolle der verlinkten Seiten ist jedoch ohne konkrete Anhaltspunkte einer
                Rechtsverletzung nicht zumutbar. Bei Bekanntwerden von Rechtsverletzungen werden wir derartige Links
                umgehend entfernen.</p>
            <h3><b>Urheberrecht</b></h3>
            <p>Die durch die Seitenbetreiber erstellten
                Inhalte und Werke auf diesen Seiten unterliegen dem deutschen Urheberrecht. Die Vervielfältigung,
                Bearbeitung, Verbreitung und jede Art der Verwertung außerhalb der Grenzen des Urheberrechtes bedürfen
                der schriftlichen Zustimmung des jeweiligen Autors bzw. Erstellers. Downloads und Kopien dieser Seite
                sind nur für den privaten, nicht kommerziellen Gebrauch gestattet. Soweit die Inhalte auf dieser Seite
                nicht vom Betreiber erstellt wurden, werden die Urheberrechte Dritter beachtet. Insbesondere werden
                Inhalte Dritter als solche gekennzeichnet. Sollten Sie trotzdem auf eine Urheberrechtsverletzung
                aufmerksam werden, bitten wir um einen entsprechenden Hinweis. Bei Bekanntwerden von Rechtsverletzungen
                werden wir derartige Inhalte umgehend entfernen.</p>
            <p style="font-size: 10pt; text-align: right;">Quelle: eRecht24</p>



            <h2>Haftungshinweis</h2>

            <p>Trotz sorgfältiger inhaltlicher Kontrolle übernehmen wir keine Haftung für die Inhalte externer Links.
                Für den
                Inhalt der verlinkten Seiten sind ausschließlich deren Betreiber verantwortlich.</p>
        </div>
""";
