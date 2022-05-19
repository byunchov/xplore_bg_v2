import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/utils.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
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

  static void showSignOutDialog(BuildContext context, WidgetRef ref) {
    showYesNoDialog(
      context,
      onConfirm: () async {
        ref.read(authControllerProvider.notifier).signOut();

        SnackbarUtils.showSnackBar(
          context,
          // title: LocaleKeys.logout.tr(),
          message: LocaleKeys.logged_out_msg.tr(),
          snackBarType: SnackBarType.success,
        );
      },
      title: LocaleKeys.logout.tr(),
      message: LocaleKeys.logout_hint.tr(),
    );
  }
}
