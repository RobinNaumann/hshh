import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/widgets/filter/v_filter_cards.dart';
import 'package:hshh/widgets/filter/v_filter_categories.dart';
import 'package:hshh/widgets/filter/v_filter_misc.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      leadingIcon: const LeadingIcon.close(),
      title: "Filter",
      body: Padded.all(
          child: ListView(
              clipBehavior: Clip.none,
              children: const [
                FilterCardsView(),
                FilterMiscView(),
                Title.h5("Kategorien"),
                FilterCategoriesView()
              ].spaced())),
    );
  }
}
