import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/presentation/gallery/widgets/gallery_stats.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class GalleryOverlayWidgets {
  static List<Widget> backButtonAndGalleryStatsOverlay(BuildContext context, int totalItems,
      {String? author}) {
    return [
      Positioned(
        top: 20,
        left: 20,
        child: SafeArea(
          child: AppbarActionWidget(
            iconData: Icons.arrow_back,
            buttonSize: 42,
            // onTap: () => Navigator.pop(context),
            onTap: () => context.router.pop(),
          ),
        ),
      ),
      Positioned(
        left: 16,
        right: 16,
        bottom: 16,
        child: GalleryStatsWidget(
          currentIndex: 1,
          totalItems: totalItems,
          showCurrentPosition: false,
          author: author,
        ),
      ),
    ];
  }

  static Widget backButtonAndTitleOverlay(BuildContext context, String heading) {
    final theme = Theme.of(context);
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: SafeArea(
        child: Row(
          children: [
            AppbarActionWidget(
              iconData: Icons.arrow_back,
              buttonSize: 42,
              onTap: () => context.router.pop(),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  // color: AppThemes.xploreAppbarColor(Theme.of(context).brightness),
                  color: theme.navigationBarTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 0.8),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                  child: Text(
                    heading,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
