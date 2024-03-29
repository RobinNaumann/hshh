import '../../../../elbe.dart';
import '../../util/inherited_theme.dart';

class ColorTheme extends StatelessWidget {
  final ColorThemeData data;
  final Widget child;

  const ColorTheme({super.key, required this.data, required this.child});

  static ColorThemeData of(BuildContext context) =>
      Theme.of<ColorThemeData>(context);

  static ColorThemeData? maybeOf(BuildContext context) =>
      Theme.maybeOf<ColorThemeData>(context);

  @override
  Widget build(BuildContext context) {
    return ElbeInheritedTheme<ColorThemeData>(data: data, child: child);
  }
}
