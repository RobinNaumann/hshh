import 'package:flutter/widgets.dart' as w;

import '../../../elbe.dart';

class Text extends StatelessWidget {
  final String value;
  final Color? color;
  final TypeStyles? style;
  final TypeVariants? variant;
  final TypeStyle? resolvedStyle;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticLabel;

  const Text(this.value,
      {super.key,
      this.color,
      this.resolvedStyle,
      this.style,
      this.variant,
      this.semanticLabel,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start});

  @override
  Widget build(BuildContext context) {
    final type = TypeTheme.of(context);
    final appliedType = (style != null ? type.get(style!) : type.selected)
        .copyWith(variant: variant)
        .merge(resolvedStyle);
    final appliedColor = color ?? ColorTheme.of(context).activeLayer.front;
    return w.Text(value,
        textAlign: textAlign,
        overflow: overflow,
        semanticsLabel: semanticLabel,
        maxLines: maxLines,
        softWrap: true,
        style: appliedType.toTextStyle(appliedColor));
  }
}
