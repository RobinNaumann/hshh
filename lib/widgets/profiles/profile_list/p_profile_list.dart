import 'package:hshh/widgets/profiles/profile_edit/p_profile_edit.dart';
import 'package:hshh/widgets/profiles/profile_list/v_profile_list.dart';

import '../../../util/elbe_ui/elbe.dart';
import '../../../util/tools.dart';

class ProfileListPage extends StatelessWidget {
  const ProfileListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      leadingIcon: const LeadingIcon.back(),
      title: "Personen",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ProfileListView(
              onPressed: (id, p) => pushPage(
                  context, ProfileEditPage(profileKey: id, profile: p))),
        )),
      ),
    );
  }
}
