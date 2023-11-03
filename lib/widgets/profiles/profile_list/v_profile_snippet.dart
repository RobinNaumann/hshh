import 'package:collection/collection.dart';
import 'package:hshh/cubits/c_profiles.dart';
import 'package:hshh/services/d_institutions.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../util/elbe_ui/elbe.dart';
import '../../../util/widgets/theme/rtitle.dart';

class ProfileSnippet extends StatelessWidget {
  final bool selected;
  final int id;
  final Profile profile;
  final VoidCallback? onPressed;

  const ProfileSnippet(
      {super.key,
      required this.id,
      required this.profile,
      this.selected = false,
      this.onPressed});

  Widget _typeView() {
    final instId = profile.get("statusorig");
    final inst = Institution.list.firstWhereOrNull((e) => e.id == instId);

    return Row(
        children: [
      Icon(inst?.type.icon ?? LucideIcons.frown),
      Expanded(
          child: Text(
        inst?.type.label ?? "unbekannt",
        variant: TypeVariants.bold,
      ))
    ].spaced(amount: 0.5, vertical: false));
  }

  @override
  Widget build(BuildContext context) {
    //final cs = Theme.of(context).colorScheme;
    return Card(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RTitle.h3(
                    "${profile.get("vorname") ?? '?'} ${profile.get("name") ?? '?'}",
                    padded: false),
                _typeView()
              ].spaced()),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(LucideIcons.check),
        )
      ],
    ));
  }
}
