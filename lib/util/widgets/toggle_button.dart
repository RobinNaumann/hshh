import 'package:flutter/material.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tools.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ToggleItem<T> {
  final T key;
  final IconData icon;
  final String label;

  const ToggleItem(
      {required this.key, required this.icon, required this.label});
}

class ToggleButton<T> extends StatelessWidget {
  final T selected;
  final List<ToggleItem<T>> items;
  final Function(T id) onSelect;

  const ToggleButton(
      {super.key,
      required this.selected,
      required this.items,
      required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: boxDeco,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(children: items.listMap((e) {
              final sel = e.key == selected;
              final color = sel ? Theme.of(context).colorScheme.primary : null;

              return InkWell(
                  onTap: () => onSelect(e.key),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 15),
                    decoration: BoxDecoration(
                        color: sel
                            ? Theme.of(context).colorScheme.primaryContainer
                            : null),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(colorScheme: const ColorScheme.light()),
                      child: Row(children: [
                        Icon(e.icon, color: color),
                        const SizedBox(width: 10),
                        Expanded(
                            child: Text(e.label,
                                style: TextStyle(color: color).bold)),
                        if (sel)
                          Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(LucideIcons.check, color: color))
                      ]),
                    ),
                  ));
            }))));
  }
}
