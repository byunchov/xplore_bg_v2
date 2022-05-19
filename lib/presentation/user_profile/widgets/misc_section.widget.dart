import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/url_launcher.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/infrastructure/theme/apptheme.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:xplore_bg_v2/presentation/user_profile/widgets/settings_tile.widget.dart';

class UserMiscSection extends StatelessWidget {
  const UserMiscSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.general_settings.tr()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const _DarkModeSwitch(),
          const SizedBox(height: 1.4),
          SettingsListTileWidget(
            title: LocaleKeys.select_lang.tr(),
            iconData: Icons.language,
            iconColor: Colors.purple,
            onPressed: () {
              context.router.navigate(const ChooseLanguageRoute());
            },
          ),
          // const Divider(),
          const SizedBox(height: 1.4),
          SettingsListTileWidget(
            title: LocaleKeys.feedback.tr(),
            iconData: Icons.email,
            iconColor: Colors.redAccent,
            onPressed: () {
              UrlLauncherUtils.launchMailTo(AppConfig.supportEmail);
            },
          ),
          const SizedBox(height: 1.4),
          SettingsListTileWidget(
            title: LocaleKeys.privacy_policy.tr(),
            iconData: Icons.policy_rounded,
            iconColor: Colors.greenAccent,
            onPressed: () {
              UrlLauncherUtils.launchWebsite(AppConfig.privacyPolicyUrl);
            },
          ),
        ],
      ),
    );
  }
}

class _DarkModeSwitch extends ConsumerWidget {
  const _DarkModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkModeEnabled = ref.watch(appThemeProvider);
    final provider = ref.watch(appThemeProvider.notifier);

    return SwitchListTile(
      value: darkModeEnabled,
      onChanged: (value) {
        provider.setThemeMode(value);
      },
      title: Text(LocaleKeys.toggle_dark_mode.tr()),
    );
  }
}
