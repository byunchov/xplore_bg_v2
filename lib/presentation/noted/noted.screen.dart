import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/noted/controllers/bookmarks.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class NotedScreen extends ConsumerWidget {
  const NotedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
      routes: const [LikedLocationsRoute(), BookmarkedLocationsRoute()],
      builder: (context, child, animation) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: AppbarTitleWidget(
              title: LocaleKeys.menu_noted.tr(),
              actions: [
                IconButton(
                  onPressed: () {
                    ref.refresh(notedPlacesProvider("likes").notifier);
                    ref.refresh(notedPlacesProvider("bookmarks").notifier);
                  },
                  icon: const Icon(Icons.refresh),
                  tooltip: "Refresh",
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: BottomNavigationBar(
                backgroundColor: theme.appBarTheme.backgroundColor,
                elevation: 0,
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.favorite),
                    label: LocaleKeys.favourites.tr(),
                    backgroundColor: theme.primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.bookmark),
                    label: LocaleKeys.bookmarks.tr(),
                    backgroundColor: theme.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          body: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}
