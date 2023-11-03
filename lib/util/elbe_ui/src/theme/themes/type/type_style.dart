import 'dart:ui';
import '../../../../elbe.dart';

enum TypeVariants { regular, bold, italic, boldItalic }

class TypeStyle {
  final String? package;
  final String fontFamily;

  final TypeVariants? variant;
  final double? fontSize;
  final double? iconSize;
  final TextDecoration? decoration;

  final List<FontFeature>? fontFeatures;

  const TypeStyle(
      {this.variant,
      this.fontSize,
      this.iconSize,
      this.fontFeatures,
      this.decoration,
      this.fontFamily = "Calistoga",
      this.package = ""});

  TypeStyle merge(TypeStyle? style) => TypeStyle(
      variant: style?.variant ?? variant,
      fontSize: style?.fontSize ?? fontSize,
      iconSize: style?.iconSize ?? iconSize,
      decoration: style?.decoration ?? decoration,
      fontFeatures: style?.fontFeatures ?? fontFeatures);

  TypeStyle get bold => merge(const TypeStyle(variant: TypeVariants.bold));
  TypeStyle get regular =>
      merge(const TypeStyle(variant: TypeVariants.regular));
  TypeStyle get italic => merge(const TypeStyle(variant: TypeVariants.italic));

  TypeStyle copyWith(
          {TypeVariants? variant,
          double? fontSize,
          double? iconSize,
          TextDecoration? decoration,
          List<FontFeature>? fontFeatures,
          String? fontFamily,
          String? package}) =>
      TypeStyle(
          variant: variant ?? this.variant,
          fontSize: fontSize ?? this.fontSize,
          iconSize: iconSize ?? this.iconSize,
          decoration: decoration ?? this.decoration,
          fontFeatures: fontFeatures ?? this.fontFeatures,
          fontFamily: fontFamily ?? this.fontFamily,
          package: fontFamily != null ? (package) : this.package);

  TextStyle toTextStyle([Color? color]) => TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      package: package,
      fontStyle:
          (variant == TypeVariants.italic || variant == TypeVariants.boldItalic)
              ? FontStyle.italic
              : null,
      fontWeight:
          (variant == TypeVariants.bold || variant == TypeVariants.boldItalic)
              ? FontWeight.bold
              : null,
      fontFeatures: fontFeatures,
      decoration: decoration);
}
