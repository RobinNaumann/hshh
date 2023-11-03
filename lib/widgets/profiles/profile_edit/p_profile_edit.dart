import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/cubits/c_profiles.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/profiles/profile_edit/v_p_fields.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../util/widgets/theme/rtitle.dart';
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
  bool get createMode => widget.key == null;
  late final Profile pData = {...?widget.profile};

  void delete() {
    context.read<ProfilesCubit>().delete(widget.profileKey!);
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

    context.read<ProfilesCubit>().set(widget.profileKey, pData);
    popPage(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => popPage(context), icon: const Icon(LucideIcons.x)),
        title: Text("Person ${createMode ? 'anlegen' : 'bearbeiten'}"),
        actions: createMode
            ? null
            : [
                IconButton(
                    onPressed: delete, icon: const Icon(LucideIcons.trash))
              ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const RTitle.h3("Status"),
            PInstitutionView(profile: pData),
            const SizedBox(height: 20),
            //
            const RTitle.h3("Persönliche Angaben"),
            PFieldsView(profile: pData, fields: ProfileEditPage._profileFields),
            const SizedBox(height: 20),
            //
            const RTitle.h3("Kontakt"),
            PFieldsView(profile: pData, fields: ProfileEditPage._contactFields),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                  icon: const Icon(LucideIcons.check),
                  onPressed: save,
                  label: const Text("speichern")),
            )
          ],
        ),
      ),
    );
  }
}
