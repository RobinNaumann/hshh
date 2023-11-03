import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get accentFont =>
    GoogleFonts.calistoga(fontSize: 17, color: Colors.black);

Color get boxColor => Colors.grey.shade500;

ColorScheme get _colorLight =>
    ColorScheme.fromSeed(seedColor: Colors.blue, onSurfaceVariant: boxColor);

ThemeData get themeData => ThemeData.light().copyWith(
    textTheme: Typography.blackHelsinki.copyWith(
      titleSmall: accentFont.copyWith(fontSize: 16),
      titleMedium: accentFont.copyWith(fontSize: 20),
      titleLarge: accentFont.copyWith(fontSize: 24),
    ),
    colorScheme: _colorLight,
    useMaterial3: true,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => _colorLight.primaryContainer),
            elevation: const MaterialStatePropertyAll(0),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(width: 0, color: Colors.transparent))))),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        focusColor: Colors.green,
        activeIndicatorBorder: const BorderSide(width: 200),
        outlineBorder: const BorderSide(color: Colors.green),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )),
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        //color: Colors.black,
        elevation: 0,
        titleTextStyle: accentFont.copyWith(fontSize: 20)));
