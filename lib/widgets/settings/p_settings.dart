import '../../bits/c_preferences.dart';
import '../../util/elbe_ui/elbe.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                        key: ColorThemeMode.light,
                        label: "Hell",
                        icon: Icons.sun),
                    MultiToggleItem(
                        key: ColorThemeMode.dark,
                        label: "Dunkel",
                        icon: Icons.moon),
                    MultiToggleItem(key: null, label: "System", icon: Icons.cog)
                  ],
                  onSelect: (v) => c.setThemeMode(v))
            ],
          ),
        )));
  }
}
