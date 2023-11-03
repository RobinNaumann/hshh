import 'package:flutter/material.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';

const Color grey = Color(0xFF808080);

extension _Fract on double {
  // ignore: unnecessary_this
  double get norm => this.clamp(0.0, 1.0);
}

extension RichColor on Color {
  bool get isBright => brightness >= 0.5;
  bool get isColored =>
      (red - green).abs() > 20 ||
      (red - blue).abs() > 20 ||
      (green - blue).abs() > 20;
  double get brightness => computeLuminance();

  Color facM(double fac) {
    final hsl = HSLColor.fromColor(this);
    final l = hsl.lightness;
    return hsl.withLightness((l - (l - 0.5) * 2 * fac).norm).toColor();
  }

  Color inter(double factor, [Color color = grey]) {
    var hsl = HSLColor.fromColor(this);
    if (hsl.lightness == 0 || hsl.lightness == 1) hsl = hsl.withSaturation(0);
    final lC = HSLColor.fromColor(color).lightness;
    final l = hsl.lightness;
    final nl = (l + (lC - l) * factor);
    return hsl.withLightness(nl.norm).toColor();
  }

  Color fac(double factor) {
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness * factor).norm).toColor();
  }

  Color get desaturated => HSLColor.fromColor(this).withSaturation(0).toColor();
}

class LayerColor extends Color {
  final Color back;
  final Color front;
  final Color border;

  LayerColor({required this.back, required this.front, required this.border})
      : super(back.value);

  factory LayerColor.fromColor(
          {required Color back, Color? front, Color? border}) =>
      LayerColor(
          back: back,
          front: back.isColored
              ? back.inter(1.4)
              : front ?? (back.isBright ? Colors.black : Colors.white),
          border: border ?? back.inter(0.4));
}

enum StateColors { neutral, hovered, pressed, disabled }

class StateColor {
  final LayerColor neutral;
  final LayerColor hovered;
  final LayerColor pressed;
  final LayerColor disabled;

  const StateColor(
      {required this.neutral,
      required this.hovered,
      required this.pressed,
      required this.disabled});

  factory StateColor.fromColor(
      {required Color neutral,
      Color? hovered,
      Color? pressed,
      Color? disabled}) {
    final LayerColor? nlk = (neutral is LayerColor) ? neutral : null;
    final dis = neutral.fac(2.2).desaturated;
    final disFront = (dis.isBright ? Colors.black : Colors.white).inter(0.9);
    return StateColor(
        neutral: nlk ?? LayerColor.fromColor(back: neutral),
        hovered: (hovered is LayerColor)
            ? hovered
            : LayerColor.fromColor(
                back: hovered ?? neutral.inter(0.2),
                front: nlk?.front.fac(0.9)),
        pressed: (pressed is LayerColor)
            ? pressed
            : LayerColor.fromColor(
                back: pressed ?? neutral.inter(0.4),
                front: nlk?.front.fac(0.7)),
        disabled: (disabled is LayerColor)
            ? disabled
            : LayerColor.fromColor(
                back: dis, front: nlk?.front.desaturated ?? disFront));
  }
  LayerColor get(StateColors state) =>
      [neutral, hovered, pressed, disabled][state.index];

  StateColor copyWith(
          {LayerColor? neutral,
          LayerColor? hovered,
          LayerColor? pressed,
          LayerColor? disabled}) =>
      StateColor(
          neutral: neutral ?? this.neutral,
          hovered: hovered ?? this.hovered,
          pressed: pressed ?? this.pressed,
          disabled: disabled ?? this.disabled);
}

enum ColorStyles {
  plain,
  minorAccent,
  majorAccent,
  minorAlertError,
  majorAlertError,
  minorAlertWarning,
  majorAlertWarning,
  majorAlertSuccess,
  minorAlertSuccess,
  minorAlertInfo,
  majorAlertInfo
}

class ColorStyle {
  static const colorError = Color(0xFFF34343);
  static const colorWarning = Color(0xFFF6C821);
  static const colorSuccess = Color(0xFF29AC5E);
  static const colorInfo = Color(0xFF2463AA);

  final StateColor plain;
  final StateColor minorAccent;
  final StateColor majorAccent;
  final StateColor minorAlertError;
  final StateColor majorAlertError;
  final StateColor minorAlertWarning;
  final StateColor majorAlertWarning;
  final StateColor majorAlertSuccess;
  final StateColor minorAlertSuccess;
  final StateColor minorAlertInfo;
  final StateColor majorAlertInfo;

  const ColorStyle(
      {required this.plain,
      required this.minorAccent,
      required this.majorAccent,
      required this.minorAlertError,
      required this.majorAlertError,
      required this.minorAlertWarning,
      required this.majorAlertWarning,
      required this.majorAlertSuccess,
      required this.minorAlertSuccess,
      required this.minorAlertInfo,
      required this.majorAlertInfo});

  factory ColorStyle.fromColor(
      {required Color base,
      required Color accent,
      StateColor? plain,
      StateColor? minorAccent,
      StateColor? majorAccent,
      StateColor? minorAlertError,
      StateColor? majorAlertError,
      StateColor? minorAlertWarning,
      StateColor? majorAlertWarning,
      StateColor? minorAlertSuccess,
      StateColor? majorAlertSuccess,
      StateColor? minorAlertInfo,
      StateColor? majorAlertInfo}) {
    const mF = 0.8;

    return ColorStyle(
        plain: plain ?? StateColor.fromColor(neutral: base),
        minorAccent: minorAccent ??
            StateColor.fromColor(neutral: accent.inter(mF, base)),
        majorAccent: majorAccent ?? StateColor.fromColor(neutral: accent),
        minorAlertError: minorAlertError ??
            StateColor.fromColor(neutral: colorError.inter(mF, base)),
        majorAlertError:
            majorAlertError ?? StateColor.fromColor(neutral: colorError),
        minorAlertWarning: minorAlertWarning ??
            StateColor.fromColor(neutral: colorWarning.inter(mF, base)),
        majorAlertWarning:
            majorAlertWarning ?? StateColor.fromColor(neutral: colorWarning),
        minorAlertSuccess: minorAlertSuccess ??
            StateColor.fromColor(neutral: colorSuccess.inter(mF, base)),
        majorAlertSuccess:
            majorAlertSuccess ?? StateColor.fromColor(neutral: colorSuccess),
        minorAlertInfo: minorAlertInfo ??
            StateColor.fromColor(neutral: colorInfo.inter(mF, base)),
        majorAlertInfo:
            minorAlertInfo ?? StateColor.fromColor(neutral: colorInfo));
  }

  StateColor get(ColorStyles s) => [
        plain,
        minorAccent,
        majorAccent,
        minorAlertError,
        majorAlertError,
        minorAlertWarning,
        majorAlertWarning,
        majorAlertSuccess,
        minorAlertSuccess,
        minorAlertInfo,
        majorAlertInfo
      ][s.index];
}

class ColorScheme {
  final ColorStyle primary;
  final ColorStyle secondary;
  final ColorStyle inverse;

  const ColorScheme(
      {required this.primary, required this.secondary, required this.inverse});

  factory ColorScheme.fromColor(
          {required Color accent,
          required Color background,
          ColorStyle? primary,
          ColorStyle? secondary,
          ColorStyle? inverse}) =>
      ColorScheme(
          primary:
              primary ?? ColorStyle.fromColor(base: background, accent: accent),
          secondary: secondary ??
              ColorStyle.fromColor(
                  base: background.inter(0.1), accent: accent.inter(0.1)),
          inverse: inverse ??
              ColorStyle.fromColor(accent: accent, base: background.inter(2)));

  ColorStyle get(ColorSchemes s) => [primary, secondary, inverse][s.index];
}

enum ColorSchemes {
  primary,
  secondary,
  inverse;

  bool get isPrimary => this == ColorSchemes.primary;
  bool get isSecondary => this == ColorSchemes.secondary;
  bool get isInverse => this == ColorSchemes.inverse;
}
