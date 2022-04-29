import 'package:flutter/material.dart';

enum SnackBarType {
  none,
  info,
  warning,
  error,
  success,
}

class SnackbarUtils {
  static void showSnackBar(
    BuildContext context, {
    SnackBarType snackBarType = SnackBarType.none,
    String? title,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(_createSnackBar(
      context,
      snackBarType: snackBarType,
      message: message,
      title: title,
    ));
  }

  static SnackBar _createSnackBar(
    BuildContext context, {
    required SnackBarType snackBarType,
    String? title,
    required String message,
  }) {
    Color color;
    IconData? iconData;

    switch (snackBarType) {
      case SnackBarType.info:
        color = Colors.lightBlue;
        iconData = Icons.info_outline_rounded;
        break;
      case SnackBarType.warning:
        color = Colors.amber;
        iconData = Icons.warning_amber_rounded;
        break;
      case SnackBarType.error:
        color = Colors.redAccent;
        iconData = Icons.error_outline_rounded;
        break;
      case SnackBarType.success:
        color = Colors.green;
        iconData = Icons.check_circle_outline_rounded;
        break;
      default:
        color = Colors.grey[700]!;
        iconData = null;
        break;
    }

    final theme = Theme.of(context);
    const textColor = Colors.white;
    const double padding = 16;

    return SnackBar(
      content: Row(
        children: [
          if (iconData != null) ...[
            Icon(iconData, color: textColor, size: theme.iconTheme.size ?? 32),
            const SizedBox(width: padding),
          ],
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700, color: textColor),
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  message,
                  style: theme.textTheme.bodyLarge?.copyWith(color: textColor),
                )
              ],
            ),
          ),
        ],
      ),
      padding: const EdgeInsets.all(padding),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
