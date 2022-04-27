import 'package:flutter/material.dart';

class AppbarTitleWidget extends StatelessWidget {
  final Widget? leading;
  final List<Widget>? actions;
  final dynamic title;
  final bool centerTitle;
  final double leadingSpaceAfter;

  const AppbarTitleWidget({
    Key? key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.leadingSpaceAfter = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Add leading action, if present
        if (leading != null) leading!,
        if (leading != null && !centerTitle) SizedBox(width: leadingSpaceAfter),
        if (title is Widget) title,
        if (title is String)
          Expanded(
            child: Text(
              title.toString(),
              style: theme.appBarTheme.titleTextStyle,
              textAlign: centerTitle ? TextAlign.center : TextAlign.start,
            ),
          ),
        ...?actions
      ],
    );
  }
}
