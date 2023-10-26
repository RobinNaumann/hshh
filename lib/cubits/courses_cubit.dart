import 'package:hshh/models/course.dart';
import 'package:hshh/services/courses_service.dart';
import 'package:hshh/util/extensions/maybe_map.dart';

import '../util/tri/tri_cubit.dart';

class CoursesCubit extends TriCubit<CoursesInfo> {
  static const provider = TriCubit.provider<CoursesCubit>;
  static const builder = TriCubit.builder<CoursesCubit, CoursesInfo>;
  static const builderSmall = TriCubit.builderSmall<CoursesCubit, CoursesInfo>;

  CoursesCubit() : super(() => CoursesService.getCoursesInfo());

  String? getCategory(int index) =>
      state.whenOrNull(onData: (d) => d.categories.maybe(index));
}
