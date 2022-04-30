import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';

class NearbyCardLoadingWidget extends StatelessWidget {
  final double elevation;
  const NearbyCardLoadingWidget({
    Key? key,
    this.elevation = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const radius = WidgetConstants.kCradBorderRadius;
    final color = theme.brightness == Brightness.light ? Colors.grey[300] : Colors.grey[700];

    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        borderRadius: BorderRadius.circular(radius),
        elevation: elevation,
        color: theme.listTileTheme.tileColor,
        child: Container(
          width: constraints.maxHeight * 0.8, // 4/3 ratio
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return Material(
                    borderRadius: BorderRadius.circular(radius),
                    elevation: elevation,
                    child: SkeletonAnimation(
                      child: Container(
                        width: constraints.maxWidth,
                        height: constraints.maxWidth * 0.95,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius),
                          color: color,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomRight,
                              child: SkeletonAnimation(
                                child: Container(
                                  height: 32,
                                  alignment: Alignment.center,
                                  width: constraints.maxWidth - radius * 2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900]?.withOpacity(0.9),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      bottomRight: Radius.circular(radius),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 9),
              Expanded(
                child: SkeletonAnimation(
                  child: Container(
                    height: theme.textTheme.titleSmall?.fontSize,
                    color: color,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
