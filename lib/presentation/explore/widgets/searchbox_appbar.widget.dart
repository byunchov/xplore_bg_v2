import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class SearchBoxAppBarWidget extends StatelessWidget {
  const SearchBoxAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      toolbarHeight: 80,
      floating: true,
      pinned: true,
      centerTitle: true,
      forceElevated: true,
      backgroundColor: AppThemes.xploreAppbarColor(theme.brightness),
      automaticallyImplyLeading: false,
      title: const _SearchBarWidget(),
    );
  }
}

class _SearchBarWidget extends StatelessWidget {
  const _SearchBarWidget({Key? key, this.radius = 8}) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (() => context.router.navigate(const SearchRoute())),
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.7),
            borderRadius: BorderRadius.circular(radius),
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
                  Icons.search,
                  size: 20,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 10),
                Text(
                  LocaleKeys.search_places,
                  style: TextStyle(color: Colors.grey[700], fontSize: 15),
                ).tr(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
