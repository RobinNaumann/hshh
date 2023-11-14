import 'package:hshh/util/elbe_ui/elbe.dart';
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
          GestureDetector(
            onTap: () => pushPage(context, _ErrorTechView(error: richError)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    richError.uiTitle,
                    textAlign: TextAlign.center,
                    style: TypeStyles.bodyL,
                    variant: TypeVariants.bold,
                  ),
                  const Spaced.vertical(0.5),
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
        title: "Fehler Details",
        leadingIcon: const LeadingIcon.close(),
        body: Padded.all(
            child: SingleChildScrollView(
                clipBehavior: Clip.none, child: Text(error.toString()))));
  }
}
