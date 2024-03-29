import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/elbe_ui/src/theme/util/inherited_theme.dart';

const titleFont = 'Calistoga';

enum TypeStyles { bodyS, bodyM, bodyL, h6, h5, h4, h3, h2, h1 }

class TypeThemeData extends ElbeInheritedThemeData {
  final TypeStyle bodyS;
  final TypeStyle bodyM;
  final TypeStyle bodyL;
  final TypeStyle h6;
  final TypeStyle h5;
  final TypeStyle h4;
  final TypeStyle h3;
  final TypeStyle h2;
  final TypeStyle h1;

  final TypeStyle? _selected;

  /// Creates a new [Typography]. To create the default typography, use [Typography.defaultTypography]
  const TypeThemeData(
      {required this.bodyS,
      required this.bodyM,
      required this.bodyL,
      required this.h6,
      required this.h5,
      required this.h4,
      required this.h3,
      required this.h2,
      required this.h1,
      TypeStyle? selected})
      : _selected = selected;

  TypeStyle get selected => _selected ?? bodyM;

  factory TypeThemeData.preset() => const TypeThemeData(
      bodyS: TypeStyle(fontSize: 12),
      bodyM: TypeStyle(fontSize: 15),
      bodyL: TypeStyle(fontSize: 18),
      h6: TypeStyle(fontSize: 16, fontFamily: titleFont),
      h5: TypeStyle(fontSize: 19, fontFamily: titleFont),
      h4: TypeStyle(fontSize: 20, fontFamily: titleFont),
      h3: TypeStyle(fontSize: 23, fontFamily: titleFont),
      h2: TypeStyle(fontSize: 25, fontFamily: titleFont),
      h1: TypeStyle(fontSize: 27, fontFamily: titleFont));

  TypeThemeData copyWith(
          {TypeStyle? bodyS,
          TypeStyle? bodyM,
          TypeStyle? bodyL,
          TypeStyle? h6,
          TypeStyle? h5,
          TypeStyle? h4,
          TypeStyle? h3,
          TypeStyle? h2,
          TypeStyle? h1,
          TypeStyle? selected}) =>
      TypeThemeData(
          bodyS: bodyS ?? this.bodyS,
          bodyM: bodyM ?? this.bodyM,
          bodyL: bodyL ?? this.bodyL,
          h6: h6 ?? this.h6,
          h5: h5 ?? this.h5,
          h4: h4 ?? this.h4,
          h3: h3 ?? this.h3,
          h2: h2 ?? this.h2,
          h1: h1 ?? this.h1,
          selected: selected ?? this.selected);

  TypeThemeData select(TypeStyle Function(TypeThemeData) select) =>
      copyWith(selected: select(this));

  TypeStyle get note => bodyS;
  TypeStyle get quote => bodyL.italic;
  TypeStyle get bodyLBold => bodyL.bold;

  TypeStyle get(TypeStyles style) =>
      [bodyS, bodyM, bodyL, h6, h5, h4, h3, h2, h1][style.index];

  @override
  List getProps() => [bodyS, bodyM, bodyL, h6, h5, h4, h3, h2, h1];

  @override
  Widget provider(Widget child) => TypeTheme(data: this, child: child);
}
