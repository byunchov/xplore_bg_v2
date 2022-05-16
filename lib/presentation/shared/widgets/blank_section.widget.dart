import 'package:flutter/material.dart';

class BlankSectionWidget extends StatelessWidget {
  final String message;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final Widget? customAction;
  final EdgeInsets iconPadding;

  const BlankSectionWidget({
    Key? key,
    required this.message,
    this.icon,
    this.iconColor,
    this.customAction,
    this.iconSize = 33,
    this.iconPadding = const EdgeInsets.only(bottom: 7),
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
                  icon,
                  size: iconSize,
                  color: iconColor ?? theme.iconTheme.color!,
                ),
              ),
            ),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 3,
              style: theme.textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (customAction != null) Flexible(child: customAction!),
        ],
      ),
    );
  }
}
