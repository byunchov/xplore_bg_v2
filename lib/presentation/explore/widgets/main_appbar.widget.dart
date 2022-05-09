import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/appbar_avatar.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class MainAppBarWidget extends ConsumerWidget {
  const MainAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authControllerProvider);

    return SliverAppBar(
      toolbarHeight: 110,
      backgroundColor: AppThemes.xploreAppbarColor(theme.brightness),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.app_title.tr(),
                  style: theme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(
                  LocaleKeys.app_description.tr(),
                  style: theme.textTheme.subtitle2,
                ).tr(),
                // const SizedBox(height: 20),
              ],
            ),
            const Spacer(),
            AppbarAvatarIcon(
              // onTap: () =>
              //     context.pushRoute(const HomeRoute(children: [UserProfileRoute()])),
              onTap: () {
                if (user != null) {
                  context.navigateTo(const UserProfileRoute());
                } else {
                  context.navigateTo(SigninRoute(onSignInCallback: (u) {}));
                }
              },
              profilePic: user?.profileImage ?? AppConfig.defaultProfilePic,
            ),
          ],
        ),
      ),
    );
  }
}
