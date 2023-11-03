import '../../../elbe.dart';

class Button extends ThemedWidget {
  final ColorStyles style;
  final IconData? icon;
  final String? label;
  final bool circle;
  final bool filled;
  final RemConstraints? constraints;
  final VoidCallback? onPressed;

  const Button(
      {super.key,
      this.icon,
      this.label,
      this.circle = false,
      this.filled = true,
      this.onPressed,
      this.constraints,
      this.style = ColorStyles.minorAccent});

  const Button.flat(
      {super.key,
      this.icon,
      this.label,
      this.circle = false,
      this.onPressed,
      this.constraints,
      this.style = ColorStyles.minorAccent})
      : filled = false;

  @override
  Widget make(context, theme) {
    return Card(
        padding: null,
        color: filled ? null : Colors.transparent,
        constraints: constraints ?? const RemConstraints(minHeight: 3.5),
        border: theme.geometry.buttonBorder ? null : Border.none,
        style: style,
        state: onPressed != null ? StateColors.neutral : StateColors.disabled,
        child: _Inkwell(
          onPressed: onPressed,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) Icon(icon!),
                if (label != null) Text(label!, variant: TypeVariants.bold)
              ].spaced(amount: 0.75)),
        ));
  }
}

class _Inkwell extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  const _Inkwell({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    final m = ColorTheme.of(context).activeStyle.pressed.back;
    return Material(
        color: Colors.transparent,
        child: onPressed == null
            ? child
            : InkWell(splashColor: m, onTap: onPressed, child: child));
  }
}
