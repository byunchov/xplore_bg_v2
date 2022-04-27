import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/infrastructure/theme/apptheme.provider.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/appbar_avatar.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets/section.widget.dart';
import 'package:xplore_bg_v2/presentation/home/controllers/home.controller.dart';
import 'package:xplore_bg_v2/presentation/screens.dart';

class ExploreScreen extends HookConsumerWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 110,
            // floating: true,
            // pinned: true,
            // centerTitle: true,
            // snap: true,
            // collapsedHeight: 0,
            expandedHeight: 110,
            backgroundColor: AppThemes.xploreAppbarColor(theme.brightness),
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
                        AppConfig.appName,
                        style: Get.textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "app_description",
                        style: Get.textTheme.subtitle2,
                      ),
                      // const SizedBox(height: 20),
                    ],
                  ),
                  const Spacer(),
                  AppbarAvatarIcon(
                    onTap: () => ref.read(nabvarPageControllerProvider.notifier).jumpTo(3),
                    profilePic: AppConfig.defaultProfilePic,
                  ),
                ],
              ),
            ),
            // bottom: TabBar(
            //   controller: tabController,
            //   tabs: [
            //     Tab(text: "test"),
            //     Tab(text: "test"),
            //   ],
            // ),
            // bottom: AppBar(
            //   toolbarHeight: 80,
            //   title: Center(child: _searchBar(context)),
            // ),
            // bottom: PreferredSize(
            //   preferredSize: const Size.fromHeight(80),
            //   child: Padding(
            //     padding: const EdgeInsets.all(16),
            //     child: Center(child: _searchBar(context)),
            //   ),
            // ),
          ),
          SliverAppBar(
            toolbarHeight: 80,
            floating: true,
            pinned: true,
            centerTitle: true,
            forceElevated: true,
            backgroundColor: AppThemes.xploreAppbarColor(theme.brightness),
            title: _searchBar(context),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: Text(
                "Препоръчани",
                style: theme.textTheme.titleLarge,
              ),
              postfix: IconButton(onPressed: () {}, icon: const Icon(Feather.arrow_right)),
              child: Container(
                width: screenSize.width,
                height: 280,
                color: Colors.blue,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: Text(
                "Близо до мен",
                style: theme.textTheme.titleLarge,
              ),
              postfix: IconButton(onPressed: () {}, icon: const Icon(Feather.arrow_right)),
              child: Container(
                width: screenSize.width,
                height: 280,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => const SearchScreen()),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.7),
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Icon(
                LineIcons.search,
                size: 20,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 10),
              Text(
                "search_places",
                style: TextStyle(color: Colors.grey[700], fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
