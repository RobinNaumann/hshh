import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hshh/util/widgets/theme/theme.dart';
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

void pushPage(BuildContext context, Widget page) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));

void popPage(BuildContext context) => Navigator.maybePop(context);

BoxDecoration get boxDeco => BoxDecoration(
    border: Border.all(color: boxColor, width: 1),
    borderRadius: BorderRadius.circular(10),
    color: Colors.white);

Widget box({required Widget child}) => Container(
    padding: const EdgeInsets.all(15), decoration: boxDeco, child: child);

TextStyle get title => GoogleFonts.calistoga();

const String dash = "—";

const String avgSymbol = "⌀";

const String chevronRight = "›";
