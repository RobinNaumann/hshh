import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/models/m_course.dart';

class HomeFilter {
  final String text;
  final bool onlyFlexicard;
  final bool onlySwimcard;
  final List<int> categories;
  final bool onlyToday;
  final bool onlyBookable;

  const HomeFilter(
      {required this.text,
      required this.onlyFlexicard,
      required this.onlySwimcard,
      required this.categories,
      required this.onlyBookable,
      required this.onlyToday});

  HomeFilter copyWith(
          {String? text,
          bool? onlyFlexicard,
          bool? onlySwimcard,
          List<int>? categories,
          bool? onlyToday,
          bool? onlyBookable}) =>
      HomeFilter(
          text: text ?? this.text,
          onlyFlexicard: onlyFlexicard ?? this.onlyFlexicard,
          onlySwimcard: onlySwimcard ?? this.onlySwimcard,
          categories: categories ?? this.categories,
          onlyToday: onlyToday ?? this.onlyToday,
          onlyBookable: onlyBookable ?? this.onlyBookable);

  const HomeFilter.initial()
      : text = "lauft",
        onlyFlexicard = false,
        onlySwimcard = false,
        categories = const [],
        onlyToday = false,
        onlyBookable = false;

  List<CourseGroup> filter(List<CourseGroup> groups) {
    final weekday = DateTime.now().weekday - 1;

    return groups
        .where((e) => onlyFlexicard ? e.flexicard : true)
        .where((e) => onlySwimcard ? e.swimcard : true)
        .where((e) => e.courses
            .where((e) =>
                (categories.isEmpty || categories.contains(e.categoryId)) &&
                (!onlyToday || e.days.contains(weekday)) &&
                (!onlyBookable || e.spacesAvailable))
            .isNotEmpty)
        .where((e) =>
            e.name.trim().toLowerCase().contains(text.trim().toLowerCase()))
        .toList();
  }
}

class FilterCubit extends Cubit<HomeFilter> {
  static Widget provider({required Widget child}) =>
      BlocProvider<FilterCubit>(create: (c) => FilterCubit(), child: child);

  static Widget builder(
          {required Widget Function(FilterCubit cubit, HomeFilter filter)
              onData}) =>
      BlocBuilder<FilterCubit, HomeFilter>(
          builder: (context, state) =>
              onData(context.read<FilterCubit>(), state));

  FilterCubit() : super(const HomeFilter.initial());

  void toggleCategory(int id) => emit(state.copyWith(
      categories: state.categories.contains(id)
          ? (List.of(state.categories)..remove(id))
          : (List.of(state.categories)..add(id))));

  void withText(String text) => emit(state.copyWith(text: text));
  void withOnlyToday(bool v) => emit(state.copyWith(onlyToday: v));
  void withOnlyBookable(bool v) => emit(state.copyWith(onlyBookable: v));
  void withOnlyFlexicard(bool o) => emit(state.copyWith(onlyFlexicard: o));
  void withOnlySwimcard(bool o) => emit(state.copyWith(onlySwimcard: o));
  void withCards(bool flexi, bool swim) =>
      emit(state.copyWith(onlyFlexicard: flexi, onlySwimcard: swim));
}
