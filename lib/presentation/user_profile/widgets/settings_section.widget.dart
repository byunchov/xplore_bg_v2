import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/url_launcher.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/infrastructure/theme/apptheme.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class UserSettingSection extends StatelessWidget {
  const UserSettingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.general_settings.tr()),
      child: Column(
        children: [
          const _DarkModeSwitch(),
          _SettingsListTile(
            title: LocaleKeys.select_lang.tr(),
            iconData: Icons.language,
            iconColor: Colors.purple,
            onPressed: () {
              context.router.navigate(const ChooseLanguageRoute());
            },
          ),
          // const Divider(),
          _SettingsListTile(
            title: LocaleKeys.feedback.tr(),
            iconData: Icons.email,
            iconColor: Colors.redAccent,
            onPressed: () {
              UrlLauncherUtils.launchMailTo(AppConfig.supportEmail);
            },
          ),
          _SettingsListTile(
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

class _SettingsListTile extends StatelessWidget {
  final String title;
  final double iconSize;
  final IconData iconData;
  final VoidCallback? onPressed;
  final Color iconColor;
  const _SettingsListTile({
    Key? key,
    required this.title,
    this.iconSize = 30,
    required this.iconData,
    required this.iconColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Container(
        height: iconSize,
        width: iconSize,
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(iconSize * 0.2),
        ),
        child: Icon(
          iconData,
          size: iconSize * 0.65,
          color: Colors.white,
        ),
      ),
      trailing: Icon(Icons.chevron_right, size: iconSize * 0.65),
      onTap: onPressed,
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
