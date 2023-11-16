import 'package:flutter/widgets.dart';

class TriError implements Exception {
  final dynamic error;

  final String uiTitle;
  final String uiMessage;
  final IconData? uiIcon;

  const TriError(this.error,
      {required this.uiTitle, required this.uiMessage, this.uiIcon});

  @override
  String toString() => "TriError: {\n"
      "uiTitle: $uiTitle,\n"
      "uiMessage: $uiMessage,\n"
      "uiIco: $uiIcon,\n"
      "error: '$error'}";
}
