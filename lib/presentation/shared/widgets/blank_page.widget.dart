import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class BlankPage extends StatelessWidget {
  final String heading;
  final IconData? icon;
  final Color? iconColor;
  final String? shortText;
  final bool divider;
  final Widget? customAction;
  final double iconSize;
  final EdgeInsets iconPadding;

  const BlankPage({
    Key? key,
    required this.heading,
    this.icon,
    this.iconColor,
    this.shortText,
    this.divider = false,
    this.customAction,
    this.iconSize = 96,
    this.iconPadding = const EdgeInsets.only(bottom: 15),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Flexible(
              child: Padding(
                padding: iconPadding,
                child: Icon(
                  icon ?? Feather.image,
                  size: iconSize,
                  color: iconColor ?? theme.iconTheme.color!,
                ),
              ),
            ),
          Flexible(
            child: Text(
              heading,
              style: theme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Flexible(
            child: Visibility(
              visible: divider,
              child: CustomDivider(
                width: MediaQuery.of(context).size.width * 0.55,
                height: 2.5,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              replacement: const SizedBox(height: 5),
            ),
          ),
          if (shortText != null)
            Flexible(
              child: Text(
                shortText!,
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 3,
                style: theme.textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (customAction != null) Flexible(child: customAction!),
        ],
      ),
    );
  }
}
