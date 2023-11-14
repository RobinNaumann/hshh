import '../../util/elbe_ui/elbe.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        title: "Einstellungen",
        leadingIcon: const LeadingIcon.close(),
        body: Padded.all(
          child: ListView(
            clipBehavior: Clip.none,
            children: [
              const Title.h5("Anzeige", topPadded: false),
              ToggleButtons(
                  selected: "light",
                  items: const [
                    MultiToggleItem(
                        key: "light", label: "Hell", icon: Icons.sun),
                    MultiToggleItem(
                        key: "dark", label: "Dunkel", icon: Icons.moon),
                    MultiToggleItem(
                        key: "system", label: "System", icon: Icons.cog)
                  ],
                  onSelect: (v) {})
            ],
          ),
        ));
  }
}
