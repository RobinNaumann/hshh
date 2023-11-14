import 'package:hshh/cubits/c_profiles.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/profiles/profile_edit/p_profile_edit.dart';
import 'package:hshh/widgets/profiles/profile_list/v_profile_snippet.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ProfileListView extends StatelessWidget {
  final int? selectedId;
  final Function(int id, Profile p) onPressed;
  const ProfileListView({super.key, this.selectedId, required this.onPressed});

  Widget _addBtn(BuildContext context) => Button.action(
      onTap: () => pushPage(context, const ProfileEditPage.create()),
      icon: LucideIcons.plus,
      label: "neue Person anlegen");

  @override
  Widget build(BuildContext context) {
    return ProfilesCubit.builder(
        onData: (c, data) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (data.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "keine Personen gespeichert",
                    textAlign: TextAlign.center,
                  ),
                ),
              ...data.entries.map<Widget>((e) => ProfileSnippet(
                  id: e.key,
                  profile: e.value,
                  onPressed: onPressed,
                  selected: e.key == selectedId)),
              _addBtn(context),
            ].spaced()));
  }
}
