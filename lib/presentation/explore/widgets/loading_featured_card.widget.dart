import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';

class FeaturedLoadingCardWidget extends StatelessWidget {
  final double elevation;

  const FeaturedLoadingCardWidget({
    Key? key,
    this.elevation = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const radius = WidgetConstants.kCradBorderRadius;
    final color = theme.brightness == Brightness.light ? Colors.grey[300] : Colors.grey[700];

    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Material(
          borderRadius: BorderRadius.circular(radius),
          elevation: elevation,
          color: theme.listTileTheme.tileColor,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, bodyConstraints) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: SkeletonAnimation(
                        child: Container(
                          width: bodyConstraints.maxWidth,
                          height: constraints.maxHeight * 0.72,
                          color: color,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 9),
                Expanded(
                  child: Center(
                    child: SkeletonAnimation(
                      child: Container(
                        height: theme.textTheme.titleMedium?.height,
                        color: color,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
