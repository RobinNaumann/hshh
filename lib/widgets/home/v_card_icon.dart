import 'package:hshh/util/elbe_ui/elbe.dart';

class CardIcon extends StatelessWidget {
  final String name;
  final IconData icon;
  const CardIcon({super.key, required this.name, required this.icon});

  const CardIcon.flexi({super.key})
      : name = "Flexicard",
        icon = Icons.functionSquare;

  const CardIcon.swim({super.key})
      : name = "Swimcard",
        icon = Icons.waves;

  @override
  Widget build(BuildContext context) {
    return IconButton.integrated(
        icon: icon,
        hint: name,
        onTap: () => showDialog(
            context: context,
            builder: (_) => AlertDialog.adaptive(
                  title: Row(
                      children: [Icon(icon), Expanded(child: Text.h6(name))]
                          .spaced(amount: 0.5)),
                  content:
                      Text("Dieses Angebot kann mit der $name besucht werden."),
                )));
  }
}
