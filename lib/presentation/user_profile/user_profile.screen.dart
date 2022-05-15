import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/dialog.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'widgets/settings_section.widget.dart';
import 'widgets/user_section.widget.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitleWidget(
          title: LocaleKeys.menu_user_profile.tr(),
          actions: [
            AppbarActionWidget(
              iconData: user.isAuthenticated ? Icons.logout : Icons.login,
              buttonSize: 42,
              onTap: () {
                if (user.isAuthenticated) {
                  _handleLogOut(context, ref);
                } else {
                  context.router.navigate(SigninRoute(onSignInCallback: (user) {
                    SnackbarUtils.showSnackBar(
                      context,
                      message: LocaleKeys.signin_user_msg.tr(namedArgs: {'name': user.fullName}),
                    );
                    context.router.pop();
                  }));
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: const [
              UserProfileSection(),
              UserSettingSection(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogOut(BuildContext context, WidgetRef ref) {
    DialogUtils.showYesNoDialog(
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
