
import '../../cubits/c_filter.dart';
import '../../util/elbe_ui/elbe.dart';

class FilterCardsView extends StatelessWidget {
  const FilterCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return FilterCubit.builder(
        onData: (cubit, filter) => ToggleButtons(
            selected:
                (filter.onlyFlexicard ? 1 : 0) + (filter.onlySwimcard ? 2 : 0),
            items: const [
              MultiToggleItem(key: 0, label: "alle Angebote anzeigen"),
              MultiToggleItem(key: 1, label: "nur mit Flexicard"),
              MultiToggleItem(key: 2, label: "nur mit Swimcard"),
              MultiToggleItem(key: 3, label: "nur mit Flexicard & Swimcard")
            ],
            onSelect: (v) => cubit.withCards(v % 2 == 1, v > 1)));
  }
}
