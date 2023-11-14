import 'package:hshh/cubits/c_courses.dart';
import 'package:hshh/cubits/c_filter.dart';

import '../../util/elbe_ui/elbe.dart';

class FilterMiscView extends ThemedWidget {
  const FilterMiscView({super.key});

  @override
  Widget make(context, theme) {
    return FilterCubit.builder(
        onData: (cubit, filter) => Column(
              children: [
                ToggleButton(
                    value: filter.onlyToday,
                    item: ToggleItem(
                        label:
                            "nur Heute (${CoursesCubit.getWeekday(DateTime.now().weekday - 1, withS: true)})"),
                    onChanged: cubit.withOnlyToday),
                ToggleButton(
                    value: filter.onlyBookable,
                    item: const ToggleItem(label: "nur mit freien Plätzen"),
                    onChanged: cubit.withOnlyBookable)
              ].spaced(),
            ));
  }
}
