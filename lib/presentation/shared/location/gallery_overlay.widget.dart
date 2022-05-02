import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/presentation/gallery/widgets/gallery_stats.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class GalleryOverlayWidgets {
  static List<Widget> backButtonAndGalleryStatsOverlay(
    BuildContext context, {
    required int totalItems,
    int currentIndex = 1,
    String? author,
    bool showCurrentPosition = false,
  }) {
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
          currentIndex: currentIndex,
          totalItems: totalItems,
          showCurrentPosition: showCurrentPosition,
          author: author,
        ),
      ),
    ];
  }

  static Widget backButtonAndTitleOverlay(BuildContext context, String heading) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final headerColor = isDarkMode ? Colors.grey[700] : Colors.grey[200];
    final headerBorderColor = isDarkMode ? Colors.grey[500]! : Colors.grey;

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
                  color: headerColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: headerBorderColor, width: 1.4),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Text(
                    heading,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    // style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
