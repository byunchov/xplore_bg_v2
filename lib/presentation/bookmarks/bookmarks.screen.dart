import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter(
      routes: const [LikedLocationsRoute(), BookmarkedLocationsRoute()],
      builder: (context, child, animation) {
        // obtain the scoped TabsRouter controller using context
        final tabsRouter = AutoTabsRouter.of(context);
        // Here we're building our Scaffold inside of AutoTabsRouter
        // to access the tabsRouter controller provided in this context
        //
        //alterntivly you could use a global key
        return Scaffold(
          appBar: AppBar(
            title: AppbarTitleWidget(
              title: tr('menu_bookmarks'),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: BottomNavigationBar(
                elevation: 0,
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(Feather.home),
                    label: LocaleKeys.favourites.tr(),
                    backgroundColor: theme.primaryColor,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Feather.compass),
                    label: LocaleKeys.favourites.tr(),
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

class _BookmarksScreen extends ConsumerWidget {
  const _BookmarksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: AppbarTitleWidget(
            title: tr('menu_bookmarks'),
          ),
          bottom: TabBar(
            indicator: UnderlineTabIndicator(
              insets: const EdgeInsets.symmetric(horizontal: 10),
              borderSide: BorderSide(color: theme.primaryColor, width: 4),
            ),
            tabs: [
              Tab(child: const Text('favourites').tr()),
              Tab(child: const Text('bookmarks').tr()),
            ],
          ),
        ),
        body: const TabBarView(children: [
          // LikedLocationsTab(),
          // BookmarkedLocationsTab(),
        ]),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => ref.refresh(bookmarkedLocationsProvider),
        //   child: const Icon(Icons.refresh),
        // ),
      ),
    );
  }
}
