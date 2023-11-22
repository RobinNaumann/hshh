import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
import 'package:hshh/widgets/profiles/profile_edit/v_p_fields.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'v_p_institution.dart';

class ProfileEditPage extends StatefulWidget {
  final int? profileKey;
  final Profile? profile;

  const ProfileEditPage(
      {super.key, required int this.profileKey, required Profile this.profile});

  const ProfileEditPage.create({super.key})
      : profileKey = null,
        profile = null;

  static const _profileFields = [
    PField(
      id: "vorname",
      label: "Vorname",
      type: TextInputType.name,
    ),
    PField(
      id: "name",
      label: "Familienname",
      type: TextInputType.name,
    ),
    PField(
      id: "strasse",
      label: "Straße & Nr.",
      type: TextInputType.streetAddress,
    ),
    PField(
      id: "ort",
      label: "PLZ & Ort",
      type: TextInputType.streetAddress,
    )
  ];

  static const _contactFields = [
    PField(
      id: "email",
      label: "Email Adresse",
      type: TextInputType.emailAddress,
    ),
    PField(
      id: "telefon",
      label: "Telefonnr.",
      type: TextInputType.phone,
    )
  ];

  @override
  State<ProfileEditPage> createState() => _PersonEditPageState();
}

class _PersonEditPageState extends State<ProfileEditPage> {
  bool get createMode => widget.profileKey == null;
  late final Profile pData = {...?widget.profile};

  void delete() {
    context.bit<ProfilesBit>().delete(widget.profileKey!);
    popPage(context);
  }

  void save() {
    if (!PInstitutionView.isValid(pData) ||
        !PFieldsView.isValid(pData, [
          ...ProfileEditPage._profileFields,
          ...ProfileEditPage._contactFields
        ])) {
      showSnackbar(context, "Fülle alle Felder aus");
      return;
    }

    context.bit<ProfilesBit>().set(widget.profileKey, pData);
    popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      heroTag:
          widget.profileKey != null ? "profile_${widget.profileKey}" : null,
      title: "Person ${createMode ? 'anlegen' : 'bearbeiten'}",
      leadingIcon: const LeadingIcon.close(),
      actions: createMode
          ? null
          : [IconButton.integrated(onTap: delete, icon: LucideIcons.trash)],
      body: Padded.all(
        child: ListView(
          clipBehavior: Clip.none,
          children: [
            const Title.h5("Status", topPadded: false),
            PInstitutionView(profile: pData),
            //
            const Title.h5("Persönliche Angaben"),
            PFieldsView(profile: pData, fields: ProfileEditPage._profileFields),
            //
            const Title.h5("Kontakt"),
            PFieldsView(profile: pData, fields: ProfileEditPage._contactFields),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Button.minor(
                  icon: LucideIcons.check, onTap: save, label: "speichern"),
            )
          ],
        ),
      ),
    );
  }
}
