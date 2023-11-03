import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onPressed;

  const ColorButton(
      {super.key, required this.label, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
