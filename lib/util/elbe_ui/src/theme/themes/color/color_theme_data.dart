import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';

enum ColorThemeMode { light, dark }

class ColorThemeData extends ElbeInheritedThemeData {
  final ColorThemeMode mode;
  final ColorSchemes scheme;
  final ColorStyles? style;
  final StateColors? state;

  final ColorScheme light;
  final ColorScheme dark;

  ColorStyle get activeScheme => map(mode).get(scheme);
  StateColor get activeStyle =>
      style != null ? activeScheme.get(style!) : activeScheme.plain;
  LayerColor get activeLayer =>
      state != null ? activeStyle.get(state!) : activeStyle.neutral;

  const ColorThemeData(
      {required this.light,
      required this.dark,
      this.mode = ColorThemeMode.light,
      this.scheme = ColorSchemes.primary,
      this.style,
      this.state});

  ColorThemeData copyWith({
    ColorThemeMode? mode,
    ColorSchemes? scheme,
    ColorStyles? style,
    StateColors? state,
    ColorScheme? light,
    ColorScheme? dark,
  }) =>
      ColorThemeData(
          light: light ?? this.light,
          dark: dark ?? this.dark,
          mode: mode ?? this.mode,
          scheme: scheme ?? this.scheme,
          style: style ?? this.style,
          state: state ?? this.state);

  factory ColorThemeData.fromColor(
          {required Color accent,
          ColorThemeMode mode = ColorThemeMode.light,
          ColorSchemes scheme = ColorSchemes.primary}) =>
      ColorThemeData(
          light:
              ColorScheme.fromColor(accent: accent, background: Colors.white),
          dark: ColorScheme.fromColor(accent: accent, background: Colors.black),
          mode: mode,
          scheme: scheme);

  ColorScheme map(ColorThemeMode mode) => [light, dark][mode.index];

  @override
  List getProps() => [light, dark];

  @override
  Widget provider(Widget child) => ColorTheme(data: this, child: child);
}
