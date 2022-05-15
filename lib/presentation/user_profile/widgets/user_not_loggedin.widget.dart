import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class UserNotLoggedInWidget extends ConsumerWidget {
  const UserNotLoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: BlankPage(
        icon: Icons.login_rounded,
        iconPadding: const EdgeInsets.only(bottom: 6),
        iconSize: 102,
        heading: LocaleKeys.not_signed_in.tr(),
        shortText: LocaleKeys.not_signed_in_desc.tr(),
        customAction: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton.icon(
            onPressed: () {
              context.router.push(SigninRoute(onSignInCallback: (user) {
                SnackbarUtils.showSnackBar(
                  context,
                  message: LocaleKeys.signin_user_msg.tr(namedArgs: {'name': user.fullName}),
                );
                context.router.pop();
              }));
            },
            icon: const Icon(Icons.login),
            label: Text(LocaleKeys.signin_btn.tr()),
          ),
        ),
      ),
    );
  }
}
