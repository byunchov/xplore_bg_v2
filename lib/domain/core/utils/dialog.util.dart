import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class DialogUtils {
  static void showYesNoDialog(
    BuildContext context, {
    required VoidCallback onConfirm,
    String? title,
    String? message,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: message != null ? Text(message) : null,
          actions: [
            TextButton(
              child: const Text(LocaleKeys.no).tr(),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text(LocaleKeys.yes).tr(),
              onPressed: () {
                onConfirm.call();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}
