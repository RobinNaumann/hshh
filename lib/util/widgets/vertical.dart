import 'package:flutter/material.dart';

class Vertical extends StatelessWidget {
  final bool scrollable;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  const Vertical(
      {super.key,
      required this.children,
      this.crossAxisAlignment = CrossAxisAlignment.stretch,
      this.scrollable = true});

  @override
  Widget build(BuildContext context) {
    return scrollable
        ? SingleChildScrollView(
            child: Column(
                crossAxisAlignment: crossAxisAlignment, children: children))
        : Column(crossAxisAlignment: crossAxisAlignment, children: children);
  }
}
