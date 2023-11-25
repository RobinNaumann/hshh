import 'dart:async';

import 'package:flutter/material.dart' as m;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hshh/bits/c_courses.dart';
import 'package:hshh/bits/c_favorites.dart';
import 'package:hshh/bits/c_filter.dart';
import 'package:hshh/bits/c_preferences.dart';
import 'package:hshh/bits/c_profiles.dart';
import 'package:hshh/services/s_devlog.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

import 'util/elbe_ui/elbe.dart';
import 'widgets/home/p_home.dart';

const accent = m.Color.fromARGB(255, 39, 142, 227);
const splash = m.Color(0xFFB0DBFF);

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await DevLog.init();
    runApp(const _AppBase());
  }, DevLog.error);
}

class _AppBase extends m.StatelessWidget {
  const _AppBase();

  Widget _providers({required Widget child}) => TriProvider(
      create: (_) => PreferencesBit(),
      child: TriProvider(
          create: (_) => ProfilesBit(),
          child: TriProvider(
              create: (_) => CoursesBit(),
              child: TriProvider(
                  create: (_) => FilterBit(),
                  child: TriProvider(
                      create: (_) => FavoritesBit(), child: child)))));

  Widget _loading() =>
      MaterialApp(home: m.Scaffold(body: Container(), backgroundColor: splash));

  @override
  m.Widget build(m.BuildContext context) {
    return _providers(
        child: PreferencesBit.builder(
            onError: (_, __) => _loading(),
            onLoading: (_) => _loading(),
            onData: (c, prefs) => Theme(
                data: ThemeData(
                    color: ColorThemeData.fromColor(
                        mode: prefs.themeMode,
                        accent: accent), // Color(0xFF1885DF)),
                    type: TypeThemeData.preset(),
                    geometry: GeometryThemeData.preset()),
                child: const _App())));
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final cTheme = ColorTheme.of(context);
    return MaterialApp(
      theme: m.ThemeData.from(
          useMaterial3: true,
          colorScheme: m.ColorScheme.fromSeed(
              seedColor: cTheme.activeScheme.majorAccent.neutral,
              brightness: cTheme.mode == ColorThemeMode.light
                  ? Brightness.light
                  : Brightness.dark)),
      title: 'HsHH',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', 'US'), Locale('de', 'DE')],
      home: const HomePage(),
    );
  }
}
