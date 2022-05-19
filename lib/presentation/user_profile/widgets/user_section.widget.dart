import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:xplore_bg_v2/presentation/user_profile/widgets/noted_stats.widget.dart';
import 'package:xplore_bg_v2/presentation/user_profile/widgets/settings_section.widget.dart';
import 'package:xplore_bg_v2/presentation/user_profile/widgets/user_avatar.widget.dart';

class UserProfileSection extends ConsumerWidget {
  const UserProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    if (user != null) {
      return const _UserLoggedInWidget();
    }
    return const UserNotLoggedInWidget();
  }
}

class _UserLoggedInWidget extends ConsumerWidget {
  const _UserLoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authControllerProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),
        const UserAvatarWidget(),
        const SizedBox(height: 16),
        Text(
          user!.fullName,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        if (user.email.isNotEmpty)
          Text(
            user.email,
            textAlign: TextAlign.center,
            maxLines: 1,
            style: theme.textTheme.subtitle1?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        const SizedBox(height: 24),
        const UserNotedStatsWidget(),
        const SizedBox(height: 16),
        const UserSettingSection(),
        const SizedBox(height: 16),
      ],
    );
  }
}
