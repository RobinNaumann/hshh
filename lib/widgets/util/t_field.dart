import '../../util/elbe_ui/elbe.dart';

class TField extends ThemedWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String value) onChanged;
  final String? label;
  const TField(
      {super.key,
      required this.controller,
      required this.keyboardType,
      required this.onChanged,
      this.label});

  @override
  Widget make(context, theme) {
    final b = theme.geometry.border;
    final bColor = theme.color.activeLayer.border;
    final bColorA = theme.color.activeScheme.minorAccent.pressed;

    final border = OutlineInputBorder(
        borderRadius: b.borderRadius ?? BorderRadius.zero,
        borderSide: BorderSide(width: b.pixelWidth ?? 0, color: bColor));
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
          //floatingLabelStyle: theme.type.bodyM.bold.toTextStyle(bColorA),
          //labelStyle: theme.type.bodyM.toTextStyle(theme.color.activeScheme.minorAccent.disabled.front),
          labelText: label,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
              borderSide:
                  border.borderSide.copyWith(color: bColorA.border, width: 3))),
    );
  }
}
