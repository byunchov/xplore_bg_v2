import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PLaceTileLoadingWidget extends StatelessWidget {
  final double cardHeight;
  final double cardBorderRadius;

  const PLaceTileLoadingWidget({
    Key? key,
    this.cardHeight = 140,
    this.cardBorderRadius = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final color = theme.brightness == Brightness.light ? Colors.grey[300] : Colors.grey[700];

    return Container(
      height: cardHeight,
      // margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.listTileTheme.tileColor,
        borderRadius: BorderRadius.circular(cardBorderRadius),
      ),
      child: Row(
        children: [
          // thumbnail animation
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(cardBorderRadius),
              bottomLeft: Radius.circular(cardBorderRadius),
            ),
            child: SkeletonAnimation(
              child: Container(
                height: cardHeight,
                width: cardHeight - 5,
                color: color,
              ),
            ),
          ),
          // body
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title animation
                  Expanded(
                    child: SkeletonAnimation(
                      child: Container(
                        width: size.width,
                        color: color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 7),
                  // location animation
                  SkeletonAnimation(
                    child: Container(
                      width: size.width * 0.43,
                      height: theme.textTheme.labelLarge?.fontSize,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 7),
                  // subcategory animation
                  SkeletonAnimation(
                    child: Container(
                      width: size.width * 0.37,
                      height: theme.textTheme.labelMedium?.fontSize,
                      color: color,
                    ),
                  ),
                  CustomDivider(
                    width: size.width * 0.22,
                    height: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  // stats
                  SkeletonAnimation(
                    child: Container(
                      width: size.width * 0.27,
                      height: theme.textTheme.labelMedium?.fontSize,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
