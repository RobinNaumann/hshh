import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/elbe_ui/src/components/core/maybe_hero.dart';

import '../../cubits/c_filter.dart';
import '../../util/tools.dart';
import '../filter/p_filter.dart';
import '../group_list/v_group_list.dart';

class SearchPage extends ThemedWidget {
  final String text;
  const SearchPage({super.key, required this.text});

  Widget _searchBar(TextEditingController ctrl, FilterCubit cubit, String text,
          bool focus) =>
      Align(
        alignment: Alignment.topCenter,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: ctrl,
                autofocus: focus,
                //style: theme.type.bodyL.bold.toTextStyle(mAcc.neutral.front),
                onChanged: cubit.withText,
                decoration: const InputDecoration(
                    //hintStyle: theme.type.bodyL.toTextStyle(mAcc.neutral.front),
                    hintText: "Suche",
                    border: InputBorder.none,
                    hintMaxLines: 1),
              ),
            ),
            if (text.isNotEmpty)
              IconButton.integrated(
                  icon: Icons.x,
                  onTap: () {
                    ctrl.text = "";
                    cubit.withText("");
                  }),
          ],
        ),
      );

  @override
  Widget make(context, theme) {
    final TextEditingController ctrl = TextEditingController(text: text);
    return Scaffold(
        leadingIcon: const LeadingIcon.back(),
        title: "",
        customTitle: FilterCubit.builder(
            onData: (cubit, filter) => MaybeHero(
                  tag: "home_search",
                  builder: (traveling) =>
                      _searchBar(ctrl, cubit, text, !traveling),
                )),
        actions: [
          IconButton.integrated(
              icon: Icons.sliders,
              onTap: () => pushPage(context, const FilterPage()))
        ],
        body: Padded.all(
            child: const SingleChildScrollView(
                clipBehavior: Clip.none, child: GroupList())));
  }
}
