import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class ReviewLoadingCardWidget extends StatelessWidget {
  final double avatarRadius;

  const ReviewLoadingCardWidget({
    Key? key,
    this.avatarRadius = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final color = theme.brightness == Brightness.light ? Colors.grey[300] : Colors.grey[700];

    return SkeletonAnimation(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        color: theme.listTileTheme.tileColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: avatarRadius,
                  child: ClipOval(
                    child: Container(color: color),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width,
                        height: theme.textTheme.subtitle1?.fontSize,
                        color: color,
                      ),
                      const SizedBox(height: 3),
                      Container(
                        width: size.width * 0.44,
                        height: theme.textTheme.subtitle2?.fontSize,
                        color: color,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: size.width * 0.27,
                  height: 20,
                  color: color,
                ),
              ],
            ),
            const SizedBox(height: 10),
            for (var i = 0; i < 2; i++) ...[
              Container(
                width: size.width,
                height: theme.textTheme.bodyMedium?.fontSize,
                color: color,
              ),
              if (i < 1) const SizedBox(height: 3),
            ],
          ],
        ),
      ),
    );
  }
}
