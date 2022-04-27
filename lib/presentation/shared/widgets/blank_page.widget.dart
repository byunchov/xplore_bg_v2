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

  const BlankPage({
    Key? key,
    required this.heading,
    this.icon,
    this.iconColor,
    this.shortText,
    this.divider = false,
    this.customAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: icon != null,
              child: Column(
                children: [
                  Icon(
                    icon ?? Feather.image,
                    size: 96,
                    color: iconColor ?? theme.iconTheme.color!,
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            Text(
              heading,
              style: theme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
            ),
            Visibility(
              visible: divider,
              child: CustomDivider(
                width: MediaQuery.of(context).size.width * 0.55,
                height: 2.5,
                margin: const EdgeInsets.symmetric(vertical: 10),
              ),
              replacement: const SizedBox(height: 5),
            ),
            if (shortText != null)
              Text(
                shortText!,
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 3,
                style: theme.textTheme.subtitle2,
                overflow: TextOverflow.ellipsis,
              ),
            if (customAction != null) customAction!,
          ],
        ),
      ),
    );
  }
}
