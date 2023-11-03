import 'package:flutter/material.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/util/tri/tri_cubit.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../cubits/c_booking_data.dart';

class BookingFormView extends StatelessWidget {
  const BookingFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BookingDataCubit.builder(
        onError: errorView,
        onLoading: loadingView,
        onData: (cubit, data) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...data.fields.listMap((e) => TextField(
                    decoration: InputDecoration(
                      labelText: e.label,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Colors.greenAccent, width: 50),
                      ),
                    ),
                    controller: TextEditingController(),
                  )),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.arrowRight),
                  label: const Text("prüfen"))
            ].spaced()));
  }
}
