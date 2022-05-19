import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/utils.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:xplore_bg_v2/presentation/user_profile/widgets/misc_section.widget.dart';

import 'widgets/settings_section.widget.dart';
import 'widgets/user_section.widget.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitleWidget(
          title: LocaleKeys.menu_user_profile.tr(),
          actions: const [
            _UserAppBarAction(),
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
              UserMiscSection(),
              _MemberSinceBadge(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserAppBarAction extends ConsumerWidget {
  const _UserAppBarAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return AppbarActionWidget(
      iconData: (user != null) ? Icons.logout : Icons.login,
      buttonSize: 42,
      onTap: () {
        if (user != null) {
          DialogUtils.showSignOutDialog(context, ref);
        } else {
          context.router.navigate(SigninRoute());
        }
      },
    );
  }
}

class _MemberSinceBadge extends ConsumerWidget {
  const _MemberSinceBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authControllerProvider);

    if (user == null) {
      return const SizedBox(height: 24);
    }

    final joinDate =
        DateTimeUtils.yMMMMdFormat(user.joinDate!.toLocal(), context.locale.languageCode);

    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Text(
        LocaleKeys.member_since.tr(namedArgs: {'date': joinDate.toString()}),
        style: theme.textTheme.caption,
      ),
    );
  }
}
