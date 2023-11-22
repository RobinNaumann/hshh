import 'package:collection/collection.dart';
import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/services/d_institutions.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/widgets/util/t_field.dart';

import '../../../util/elbe_ui/elbe.dart';

class PInstitutionView extends StatefulWidget {
  static bool isValid(Profile p) {
    final i = _get(p);

    return i != null &&
        ((i.type.isGuest) ||
            (i.type.isStudent && (p.get("matnr") ?? "").trim().isNotEmpty) ||
            (i.type.isWorker && (p.get("mitnr") ?? "").trim().isNotEmpty));
  }

  static Institution? _get(Profile p) =>
      Institution.list.firstWhereOrNull((e) => e.id == p.get("statusorig"));

  final Profile profile;
  const PInstitutionView({super.key, required this.profile});

  @override
  State<PInstitutionView> createState() => _PIInstitutionViewState();
}

class _PIInstitutionViewState extends State<PInstitutionView> {
  late Institution inst;
  late TextEditingController matnr;
  late TextEditingController mitnr;

  Institution _setDefault() {
    final i = Institution.list.last;
    setInst(i, reload: false);
    return i;
  }

  @override
  void initState() {
    matnr = TextEditingController(text: widget.profile.get("matnr"));
    mitnr = TextEditingController(text: widget.profile.get("mitnr"));
    inst = PInstitutionView._get(widget.profile) ?? _setDefault();

    super.initState();
  }

  void setInst(Institution i, {bool reload = true}) {
    widget.profile["statusorig"] = i.id;
    widget.profile.remove("matnr");
    widget.profile.remove("mitnr");
    matnr.clear();
    mitnr.clear();

    setState(() => inst = i);
  }

  void setMatNr(String v) => widget.profile["matnr"] = v.trim();
  void setMitNr(String v) => widget.profile["mitnr"] = v.trim();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ToggleButtons(
            selected: inst.type,
            items: InstitutionType.values.listMap(
                (e) => MultiToggleItem(key: e, icon: e.icon, label: e.label)),
            onSelect: (e) =>
                setInst(Institution.list.firstWhere((i) => i.type == e))),
        if (!inst.type.isGuest)
          Card(
            child: DropdownButton(
                isDense: true,
                underline: Container(),
                borderRadius: GeometryTheme.of(context).border.borderRadius,
                value: inst.id,
                style: TypeTheme.of(context).bodyLBold.toTextStyle(),
                isExpanded: true,
                items: Institution.list
                    .where((e) => e.type == inst.type)
                    .map((e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(
                          e.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )))
                    .toList(),
                onChanged: (e) => setState(() =>
                    inst = Institution.list.firstWhere((i) => i.id == e))),
          ),
        if (inst.type.isStudent)
          TField(
            controller: matnr,
            onChanged: setMatNr,
            label: "Matrikelnummer",
            keyboardType: TextInputType.text,
          ),
        if (inst.type.isWorker)
          TField(
              controller: mitnr,
              onChanged: setMitNr,
              label: "dienstl. Telefonnnr.",
              keyboardType: TextInputType.phone)
      ].spaced(),
    );
  }
}
