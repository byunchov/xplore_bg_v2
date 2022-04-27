import 'package:auto_route/auto_route.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/home/controllers/home.controller.dart';
import 'package:xplore_bg_v2/presentation/screens.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return AutoTabsScaffold(
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
                title: const Text('menu_home').tr(),
                activeColor: theme.primaryColor,
              ),
              BottomBarItem(
                icon: const Icon(Feather.compass),
                title: const Text('menu_landmarks').tr(),
                activeColor: theme.primaryColor,
              ),
              BottomBarItem(
                icon: const Icon(Feather.bookmark),
                title: const Text('menu_bookmarks').tr(),
                activeColor: theme.primaryColor,
              ),
              BottomBarItem(
                icon: const Icon(Feather.user),
                title: const Text('menu_user_profile').tr(),
                activeColor: theme.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeScreen extends ConsumerWidget {
  const _HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final controller = ref.read(nabvarPageControllerProvider.notifier);
    final currentPageIndex = ref.watch(nabvarPageControllerProvider);

    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          ExploreScreen(),
          LandmarkCategoriesScreen(),
          BookmarksScreen(),
          UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          // color: Get.theme.bottomNavigationBarTheme.backgroundColor,
          color: theme.bottomNavigationBarTheme.backgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 22,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: BottomBar(
          selectedIndex: currentPageIndex,
          showActiveBackgroundColor: true,
          height: 70,
          onTap: (index) {
            // ref.watch(currentPageIndexProvider.notifier).state = index;
            controller.animateTo(index);
          },
          items: [
            BottomBarItem(
              icon: const Icon(Feather.home),
              title: const Text('menu_home').tr(),
              activeColor: theme.primaryColor,
            ),
            BottomBarItem(
              icon: const Icon(Feather.compass),
              title: const Text('menu_landmarks').tr(),
              activeColor: theme.primaryColor,
            ),
            BottomBarItem(
              icon: const Icon(Feather.bookmark),
              title: const Text('menu_bookmarks').tr(),
              activeColor: theme.primaryColor,
            ),
            BottomBarItem(
              icon: const Icon(Feather.user),
              title: const Text('menu_user_profile').tr(),
              activeColor: theme.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
