import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';

class GalleryListViewWLoadingWidget extends StatelessWidget {
  const GalleryListViewWLoadingWidget({
    Key? key,
    this.loadingItems = 5,
  }) : super(key: key);
  final int loadingItems;

  @override
  Widget build(BuildContext context) {
    const borderRadius = WidgetConstants.kCradBorderRadius;
    final theme = Theme.of(context);
    final color = theme.brightness == Brightness.light ? Colors.grey[300] : Colors.grey[700];

    return SizedBox(
      height: 150,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: loadingItems,
        itemBuilder: (_, __) => LayoutBuilder(builder: (ctx, constraints) {
          return Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(borderRadius),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: SkeletonAnimation(
                child: Container(
                  width: constraints.maxHeight,
                  color: color,
                ),
              ),
            ),
          );
        }),
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }
}
