import 'package:flutter/material.dart';

class AppbarActionWidget extends StatelessWidget {
  final IconData iconData;
  final double? iconSize;
  final double buttonSize;
  final double btnBorderRadius;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;

  const AppbarActionWidget({
    Key? key,
    required this.iconData,
    this.iconSize,
    required this.buttonSize,
    this.btnBorderRadius = 6.5,
    required this.onTap,
    this.padding = const EdgeInsets.all(10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final theme = Theme.of(context);
    final double effectiveIconSize = iconSize ?? buttonSize * 0.55;

    return SizedBox.square(
      dimension: buttonSize,
      child: Material(
        borderRadius: BorderRadius.circular(btnBorderRadius),
        color: isDarkMode ? Colors.grey[700] : Colors.grey[350],
        child: InkWell(
          borderRadius: BorderRadius.circular(btnBorderRadius),
          child: Center(
            child: Icon(iconData, size: effectiveIconSize),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
