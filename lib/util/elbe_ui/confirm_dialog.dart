import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget _adaptiveAction(
    {required BuildContext context,
    required VoidCallback onPressed,
    required Widget child}) {
  final ThemeData theme = Theme.of(context);
  switch (theme.platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      return TextButton(onPressed: onPressed, child: child);
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
      return CupertinoDialogAction(onPressed: onPressed, child: child);
  }
}

void showConfirmDialog(BuildContext context,
        {required String title,
        required String text,
        String confirmLabel = "OK",
        required Function() onConfirm}) =>
    showDialog(
        context: context,
        builder: (c) => AlertDialog.adaptive(
              title: Text(title),
              content: Text(text),
              actions: [
                _adaptiveAction(
                    context: context,
                    onPressed: () => Navigator.of(context).maybePop(),
                    child: const Text("abbrechen")),
                _adaptiveAction(
                    context: context,
                    onPressed: () {
                      Navigator.of(context).maybePop();
                      onConfirm();
                    },
                    child: Text(confirmLabel))
              ],
            ));
