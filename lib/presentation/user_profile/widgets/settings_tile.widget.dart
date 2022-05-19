import 'package:flutter/material.dart';

class SettingsListTileWidget extends StatelessWidget {
  final String title;
  final double iconSize;
  final IconData iconData;
  final VoidCallback? onPressed;
  final Color iconColor;
  const SettingsListTileWidget({
    Key? key,
    required this.title,
    this.iconSize = 30,
    required this.iconData,
    required this.iconColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Container(
        height: iconSize,
        width: iconSize,
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(iconSize * 0.2),
        ),
        child: Icon(
          iconData,
          size: iconSize * 0.65,
          color: Colors.white,
        ),
      ),
      trailing: Icon(Icons.chevron_right, size: iconSize * 0.65),
      onTap: onPressed,
    );
  }
}
