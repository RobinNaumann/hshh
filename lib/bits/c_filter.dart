import 'package:hshh/models/m_course.dart';
import 'package:hshh/models/m_data.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

class HomeFilter extends DataModel {
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
      : text = "",
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

  @override
  JsonMap get map => {
        "text": text,
        "onlyFlexicard": onlyFlexicard,
        "onlySwimcard": onlySwimcard,
        "categories": categories,
        "onlyToday": onlyToday,
        "onlyBookable": onlyBookable
      };
}

class FilterBit extends TriBit<HomeFilter> {
  static const builder = TriBuilder<HomeFilter, FilterBit>.make;

  FilterBit() : super(null, initial: const HomeFilter.initial());

  void _emit(Function(HomeFilter d) onData) =>
      emit(state.whenOrNull(onData: onData));

  void toggleCategory(int id) => _emit((d) => d.copyWith(
      categories: d.categories.contains(id)
          ? (List.of(d.categories)..remove(id))
          : (List.of(d.categories)..add(id))));

  void withText(String text) => _emit((d) => d.copyWith(text: text));
  void withOnlyToday(bool v) => _emit((d) => d.copyWith(onlyToday: v));
  void withOnlyBookable(bool v) => _emit((d) => d.copyWith(onlyBookable: v));
  void withOnlyFlexicard(bool o) => _emit((d) => d.copyWith(onlyFlexicard: o));
  void withOnlySwimcard(bool o) => _emit((d) => d.copyWith(onlySwimcard: o));
  void withCards(bool flexi, bool swim) =>
      _emit((d) => d.copyWith(onlyFlexicard: flexi, onlySwimcard: swim));
}
