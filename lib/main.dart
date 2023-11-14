import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hshh/cubits/c_courses.dart';
import 'package:hshh/cubits/c_favorites.dart';
import 'package:hshh/cubits/c_filter.dart';
import 'package:hshh/cubits/c_profiles.dart';
import 'package:flutter/material.dart' as m;

import 'util/elbe_ui/elbe.dart';
import 'widgets/home/p_home.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const _AppBase());
}

class _AppBase extends m.StatelessWidget {
  const _AppBase();

  @override
  m.Widget build(m.BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProfilesCubit()),
          BlocProvider(create: (_) => CoursesCubit()),
          BlocProvider(create: (_) => FilterCubit()),
          BlocProvider(create: (_) => FavoritesCubit()),
        ],
        child: Theme(
            data: ThemeData(
                color: ColorThemeData.fromColor(
                    mode: null, accent: Colors.blue), // Color(0xFF1885DF)),
                type: TypeThemeData.preset(),
                geometry: GeometryThemeData.preset()),
            child: const _App()));
  }
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    final cTheme = ColorTheme.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
