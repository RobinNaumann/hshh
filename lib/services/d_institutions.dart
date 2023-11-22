import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum InstitutionType {
  student("Student:in / Azubi", LucideIcons.graduationCap),
  worker("Mitarbeiter:in", LucideIcons.hotel),
  guest("Gast", LucideIcons.luggage);

  const InstitutionType(this.label, this.icon);
  final String label;
  final IconData icon;

  bool get isStudent => this == InstitutionType.student;
  bool get isWorker => this == InstitutionType.worker;
  bool get isGuest => this == InstitutionType.guest;

  static InstitutionType? maybe(String? name) =>
      InstitutionType.values.firstWhereOrNull((e) => e.name == (name ?? ""));
}

class Institution {
  final String id;
  final String name;
  final InstitutionType type;

  String get label => name.replaceMulti(
      ["Bed. der ", "Bed. des ", "Stud. der ", "Stud. des "], "").trim();

  const Institution(
      {required this.id,
      required this.name,
      this.type = InstitutionType.student});

  static const List<Institution> list = [
    Institution(id: "S-UNIH", name: "Stud. der UNI Hamburg"),
    Institution(id: "S-AMS", name: "Stud. der Asklepios Medical School"),
    Institution(id: "S-AMD", name: "Stud. der AMD Akademie Mode &amp; Design"),
    Institution(id: "S-BHH", name: "Stud. der Beruflichen Hochschule Hamburg "),
    Institution(id: "S-BAH", name: "Stud. der Berufsakademie Hamburg"),
    Institution(id: "S-BLS", name: "Stud. der Bucerius Law School"),
    Institution(id: "S-BSP", name: "Stud. der Business School Berlin"),
    Institution(id: "S-HCUH", name: "Stud. der HafenCity Universität Hamburg"),
    Institution(id: "S-HFH", name: "Stud. der HFH - Hamburger FHS"),
    Institution(
        id: "S-HFrs",
        name:
            "Stud. der Hochschule Fresenius / Charlotte Fresenius Hochschule"),
    Institution(id: "S-SBA", name: "Stud. der HSBA"),
    Institution(
        id: "S-HAW", name: "Stud. der HS für Angewandte Wissenschaften"),
    Institution(id: "S-HfbK", name: "Stud. der HS für bildende Künste"),
    Institution(id: "S-HfMT", name: "Stud. der HS für Musik und Theater"),
    Institution(id: "S-IUBH", name: "Stud. der IUBH Duales Studium"),
    Institution(id: "S-KLU", name: "Stud. der Kühne Logistics University "),
    Institution(id: "S-MAC", name: "Stud. der Hochschule Macromedia"),
    Institution(id: "S-MSH", name: "Stud. der Medical School Hamburg"),
    Institution(id: "S-NBS", name: "Stud. der NBS - Northern Business School"),
    Institution(
        id: "S-NAFS",
        name: "Stud. der Norddeutschen Akademie für Finanzen und Steuerrecht"),
    Institution(id: "S-TUHH", name: "Stud. der TU Hamburg"),
    Institution(id: "S-UMCH", name: "Stud. der UMCH"),
    Institution(
        id: "S-HdPol",
        name: "AZUBI / Stud. der Akademie der Polizei Hamburg",
        type: InstitutionType.student),
    Institution(
        id: "B-UNIH",
        name: "Bed. der UNI Hamburg",
        type: InstitutionType.worker),
    Institution(
        id: "B-HdPol",
        name: "Bed. der Akademie der Polizei Hamburg",
        type: InstitutionType.worker),
    Institution(
        id: "B-AMD",
        name: "Bed. der AMD Akademie Mode &amp; Design",
        type: InstitutionType.worker),
    Institution(
        id: "B-AMS",
        name: "Bed. der Asklepios Medical School",
        type: InstitutionType.worker),
    Institution(
        id: "B-BHH",
        name: "Bed. der Beruflichen Hochschule Hamburg ",
        type: InstitutionType.worker),
    Institution(
        id: "B-BAH",
        name: "Bed. der Berufsakademie Hamburg",
        type: InstitutionType.worker),
    Institution(
        id: "B-BLS",
        name: "Bed. der Bucerius Law School",
        type: InstitutionType.worker),
    Institution(
        id: "B-BSP",
        name: "Bed. der Business School Berlin",
        type: InstitutionType.worker),
    Institution(
        id: "B-HCUH",
        name: "Bed. der HafenCity Universität Hamburg",
        type: InstitutionType.worker),
    Institution(
        id: "B-HFH",
        name: "Bed. der HFH - Hamburger FHS",
        type: InstitutionType.worker),
    Institution(
        id: "B-HFrs",
        name: "Bed. der Hochschule Fresenius / Charlotte Fresenius Hochschule",
        type: InstitutionType.worker),
    Institution(
        id: "B-SBA", name: "Bed. der HSBA", type: InstitutionType.worker),
    Institution(
        id: "B-HAW",
        name: "Bed. der HS für Angewandte Wissenschaften",
        type: InstitutionType.worker),
    Institution(
        id: "B-HfbK",
        name: "Bed. der HS für bildende Künste",
        type: InstitutionType.worker),
    Institution(
        id: "B-HfMT",
        name: "Bed. der HS für Musik und Theater",
        type: InstitutionType.worker),
    Institution(
        id: "B-IUBH",
        name: "Bed. der IUBH Duales Studium",
        type: InstitutionType.worker),
    Institution(
        id: "B-KLU",
        name: "Bed. der Kühne Logistics University ",
        type: InstitutionType.worker),
    Institution(
        id: "B-MAC",
        name: "Bed. der Hochschule Macromedia",
        type: InstitutionType.worker),
    Institution(
        id: "B-MPI",
        name: "Bed. der Max Planck Institute",
        type: InstitutionType.worker),
    Institution(
        id: "B-MSH",
        name: "Bed. der Medical School Hamburg",
        type: InstitutionType.worker),
    Institution(
        id: "B-NBS",
        name: "Bed. der NBS - Northern Business School",
        type: InstitutionType.worker),
    Institution(
        id: "B-NAFS",
        name: "Bed. der Norddeutschen Akademie für Finanzen und Steuerrecht",
        type: InstitutionType.worker),
    Institution(
        id: "B-StuWe",
        name: "Bed. des Studierendenwerk Hamburg",
        type: InstitutionType.worker),
    Institution(
        id: "B-TUHH",
        name: "Bed. der TU Hamburg",
        type: InstitutionType.worker),
    Institution(
        id: "B-UKE", name: "Bed. des UKE", type: InstitutionType.worker),
    Institution(
        id: "B-UMCH", name: "Bed. der UMCH", type: InstitutionType.worker),
    Institution(
        id: "B-FHH",
        name: "Beschäftigte der Freien und Hansestadt Hamburg",
        type: InstitutionType.worker),
    Institution(id: "Extern", name: "Gäste", type: InstitutionType.guest),
  ];
}
