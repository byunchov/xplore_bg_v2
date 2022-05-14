import 'package:auto_route/auto_route.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AutoTabsScaffold(
      // navigatorObservers: () => [HeroController()],
      routes: const [
        ExploreRoute(),
        LandmarksRouter(),
        NotedLocationsRouter(),
        UserProfileRoute(),
      ],
      bottomNavigationBuilder: (ctx, tabsRouter) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: theme.bottomNavigationBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 22,
              color: Colors.black.withOpacity(0.12),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BottomBar(
            selectedIndex: tabsRouter.activeIndex,
            showActiveBackgroundColor: true,
            height: 70,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomBarItem(
                icon: const Icon(Feather.home),
                title: const Text(LocaleKeys.menu_home).tr(),
                activeColor: theme.primaryColor,
              ),
              BottomBarItem(
                icon: const Icon(Feather.compass),
                title: const Text(LocaleKeys.menu_landmarks).tr(),
                activeColor: theme.primaryColor,
              ),
              BottomBarItem(
                icon: const Icon(Feather.bookmark),
                title: const Text(LocaleKeys.menu_noted).tr(),
                activeColor: theme.primaryColor,
              ),
              BottomBarItem(
                icon: const Icon(Feather.user),
                title: const Text(LocaleKeys.menu_user_profile).tr(),
                activeColor: theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
