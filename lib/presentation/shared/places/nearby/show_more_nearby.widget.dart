import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';

class NearbyShowMoreCardWidget extends StatelessWidget {
  final double elevation;
  const NearbyShowMoreCardWidget({
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
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {},
          child: Container(
            width: constraints.maxHeight * 0.5, // 4/3 ratio
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              // color: theme.listTileTheme.tileColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Material(
                        borderRadius: BorderRadius.circular(radius),
                        elevation: elevation,
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxWidth * 0.95,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: color,
                          ),
                          child: Icon(
                            Feather.arrow_right,
                            size: constraints.maxWidth * 0.36,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // const Icon(Feather.arrow_right),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    LocaleKeys.show_more,
                    style: theme.textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ).tr(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
