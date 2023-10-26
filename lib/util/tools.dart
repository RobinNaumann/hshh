import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final Logger logger = Logger(
  printer: PrettyPrinter(methodCount: 0, noBoxingByDefault: true),
);

String durationToString(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));

  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}

void showSnackbar(BuildContext context, String text) {
  final snackBar = SnackBar(content: Text(text));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Widget box({required Widget child}) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white),
    child: child);

const String dash = "—";

const String avgSymbol = "⌀";

const String chevronRight = "›";
