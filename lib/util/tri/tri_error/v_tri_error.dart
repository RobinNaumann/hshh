import 'package:flutter/material.dart';
import 'package:hshh/util/tools.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../tri_cubit.dart';
import 'm_tri_error.dart';

class TriErrorView extends StatelessWidget {
  final TriCubit cubit;
  final dynamic error;

  const TriErrorView({super.key, required this.cubit, this.error});

  @override
  Widget build(BuildContext context) {
    TriError richError = (error is TriError)
        ? error
        : TriError(error,
            uiTitle: "unbekannter Fehler",
            uiMessage: "ein unbekannter Fehler ist aufgetreten");

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(richError.uiIcon ?? LucideIcons.alertCircle),
          const SizedBox(height: 18),
          InkWell(
            onTap: () => pushPage(context, _ErrorTechView(error: richError)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(richError.uiTitle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17)),
                  const SizedBox(height: 3),
                  Text(
                    richError.uiMessage,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                ]),
          ),
          TextButton.icon(
              onPressed: cubit.reload,
              icon: const Icon(LucideIcons.rotateCcw),
              label: const Text("neu laden"))
        ],
      ),
    );
  }
}

class _ErrorTechView extends StatelessWidget {
  final TriError error;
  const _ErrorTechView({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Fehler Details")),
        body: SingleChildScrollView(child: Text(error.toString())));
  }
}
