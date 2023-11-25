import 'package:collection/collection.dart';
import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/services/d_institutions.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/util/tools.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../util/elbe_ui/elbe.dart';
import '../profile_edit/p_profile_edit.dart';

class ProfileSnippet extends StatelessWidget {
  final bool? selected;
  final int id;
  final Profile profile;
  final Function(int id, Profile p)? onPressed;

  const ProfileSnippet(
      {super.key,
      required this.id,
      required this.profile,
      this.selected,
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
        heroTag: "profile_$id",
        onLongTap: onPressed != null
            ? () => pushPage(
                context, ProfileEditPage(profileKey: id, profile: profile))
            : null,
        onTap: onPressed != null ? () => onPressed!(id, profile) : null,
        style: (selected ?? false) ? ColorStyles.minorAccent : null,
        state: onPressed != null ? null : ColorStates.disabled,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text.h6(
                    "${profile.get("vorname") ?? '?'} ${profile.get("name") ?? '?'}",
                  ),
                  _typeView()
                ].spaced()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: selected != null
                ? Icon(selected! ? Icons.checkCircle : Icons.circle)
                : const SizedBox.shrink(),
          )
        ]));
  }
}
