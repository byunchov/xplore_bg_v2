import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/utils.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:xplore_bg_v2/presentation/user_profile/widgets/settings_tile.widget.dart';

class UserSettingSection extends ConsumerWidget {
  const UserSettingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.user_lbl.tr()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SettingsListTileWidget(
            title: LocaleKeys.edit_profile.tr(),
            iconData: Icons.edit,
            iconColor: Colors.orangeAccent,
            onPressed: () {
              context.router.push(const EditUserProfileRoute());
            },
          ),
          const SizedBox(height: 1.4),
          SettingsListTileWidget(
            title: LocaleKeys.logout.tr(),
            iconData: Icons.logout_outlined,
            iconColor: Colors.blueGrey,
            onPressed: () {
              DialogUtils.showSignOutDialog(context, ref);
            },
          ),
          const SizedBox(height: 1.4),
          SettingsListTileWidget(
            title: LocaleKeys.delete_account.tr(),
            iconData: Icons.delete_forever_outlined,
            iconColor: Colors.red,
            onPressed: () {
              DialogUtils.showYesNoDialog(
                context,
                title: LocaleKeys.delete.tr(),
                message: LocaleKeys.delete_account_confirm.tr(),
                onConfirm: () async {
                  try {
                    await ref.read(authControllerProvider.notifier).deleteUserAccount();
                  } on Failure catch (e) {
                    SnackbarUtils.showSnackBar(
                      context,
                      message: e.message,
                      snackBarType: SnackBarType.error,
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
