import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hshh/cubits/c_courses.dart';
import 'package:hshh/cubits/c_profiles.dart';

import 'util/elbe_ui/elbe.dart';
import 'util/widgets/theme/theme.dart';
import 'widgets/home/p_home.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProfilesCubit()),
          BlocProvider(create: (_) => CoursesCubit()),
        ],
        child: Theme(
          data: ThemeData(
              color: ColorThemeData.fromColor(accent: Color(0xFF1885DF)),
              type: TypeThemeData.preset(),
              geometry: GeometryThemeData.preset()),
          child: MaterialApp(
            title: 'HsHH',
            theme: themeData,
            home: const HomePage(),
          ),
        ));
  }
}
