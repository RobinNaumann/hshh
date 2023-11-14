import 'package:flutter/material.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/json_tools.dart';

import '../../../cubits/c_profiles.dart';
import '../../util/t_field.dart';

class PField {
  final String id;
  final String label;
  final TextInputType type;

  const PField(
      {required this.id, required this.label, this.type = TextInputType.text});
}

class PFieldsView extends StatelessWidget {
  static bool isValid(Profile p, List<PField> fields) {
    for (final f in fields) {
      if ((p.get(f.id) ?? "").trim().isEmpty) return false;
    }
    return true;
  }

  final List<PField> fields;
  final Profile profile;

  const PFieldsView({super.key, required this.profile, required this.fields});

  static Widget field(JsonMap<String> vs, PField field) => TField(
      controller: TextEditingController(text: vs.get(field.id)),
      keyboardType: field.type,
      label: field.label,
      onChanged: (v) => vs[field.id] = v);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: fields.listMap((e) => field(profile, e)).spaced());
  }
}
