import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class SectionTitleWithDividerWidget extends StatelessWidget {
  final String headline;
  const SectionTitleWithDividerWidget(
    this.headline, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headline,
          style: theme.textTheme.titleLarge,
        ),
        const CustomDivider(
          width: 60,
          height: 3,
          margin: EdgeInsets.only(top: 10),
        ),
      ],
    );
  }
}
