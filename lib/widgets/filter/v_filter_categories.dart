import 'package:hshh/bits/c_courses.dart';
import 'package:hshh/bits/c_filter.dart';
import 'package:hshh/util/extensions/maybe_map.dart';

import '../../util/elbe_ui/elbe.dart';

class FilterCategoriesView extends ThemedWidget {
  const FilterCategoriesView({super.key});

  @override
  Widget make(context, theme) {
    return CoursesBit.builder(
        small: true,
        onData: (cubit, groupInfo) => FilterBit.builder(
              onData: (cubit, filter) => Wrap(
                  spacing: theme.rem(1) ?? 0,
                  runSpacing: theme.rem(1) ?? 0,
                  children: groupInfo.categories.entries
                      .where((e) => e.value.trim().isNotEmpty)
                      .toList()
                      .listMap((e) {
                    final isSel = filter.categories.contains(e.key);
                    return Card(
                      padding: const RemInsets.all(0.6),
                      style:
                          isSel ? ColorStyles.minorAccent : ColorStyles.plain,
                      state: filter.categories.isEmpty || isSel
                          ? null
                          : ColorStates.disabled,
                      child: Text(e.value),
                      onTap: () => cubit.toggleCategory(e.key),
                    );
                  })),
            ));
  }
}
