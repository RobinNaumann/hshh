import 'package:flutter/material.dart';

class RTitle extends StatelessWidget {
  final bool padded;
  final String text;
  final int level;

  const RTitle.h1(this.text, {super.key, this.padded = true}) : level = 1;
  const RTitle.h2(this.text, {super.key, this.padded = true}) : level = 2;
  const RTitle.h3(this.text, {super.key, this.padded = true}) : level = 3;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: padded
          ? EdgeInsets.only(top: 25.0 + 3 * level, bottom: 12.0 + 3 * level)
          : const EdgeInsets.all(0),
      child: Text(text,
          style: level <= 1
              ? t.titleLarge
              : (level == 2 ? t.titleMedium : t.titleSmall)),
    );
  }
}
