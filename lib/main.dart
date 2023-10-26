import 'package:flutter/material.dart';
import 'package:hshh/cubits/courses_cubit.dart';
import 'package:hshh/services/courses_service.dart';
import 'package:hshh/widgets/group_list/group_list_v.dart';

import 'widgets/home/home_p.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CoursesCubit.provider(
        cubit: CoursesCubit(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple, background: Colors.white),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ));
  }
}
