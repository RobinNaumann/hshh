import 'package:hshh/cubits/c_filter.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/filter/p_filter.dart';
import 'package:hshh/widgets/home/p_search.dart';

import '../../util/elbe_ui/elbe.dart';
import '../../util/elbe_ui/src/components/core/maybe_hero.dart';

class GroupFilterView extends ThemedWidget {
  const GroupFilterView({super.key});

  @override
  Widget make(context, theme) {
    final mAcc = theme.color.activeScheme.minorAccent;
    return Column(
        children: [
      MaybeHero(
          tag: "home_search",
          child: Card(
            style: ColorStyles.minorAccent,
            border: Border.none,
            padding:
                const RemInsets(left: 1, right: 0.5, top: 0.4, bottom: 0.4),
            child: FilterCubit.builder(onData: (cubit, filter) {
              return Row(
                  children: [
                Expanded(
                  child: InkWell(
                      onTap: () =>
                          pushPage(context, SearchPage(text: filter.text)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.search),
                          Expanded(
                            child: Padded.only(
                              top: 0.15,
                              child: Text(
                                  filter.text.isNotEmpty
                                      ? filter.text
                                      : "Suche",
                                  variant: filter.text.isNotEmpty
                                      ? TypeVariants.bold
                                      : null),
                            ),
                          ),
                          if (filter.text.isNotEmpty)
                            IconButton.action(
                                icon: Icons.x, onTap: () => cubit.withText("")),
                        ].spaced(amount: 0.6),
                      )),
                ),
                IconButton.action(
                    icon: Icons.sliders,
                    onTap: () => pushPage(context, const FilterPage()))
              ].spaced());
            }),
          )),
    ].spaced());
  }
}
