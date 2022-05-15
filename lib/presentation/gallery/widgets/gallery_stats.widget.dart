import 'package:flutter/material.dart';

class GalleryStatsWidget extends StatelessWidget {
  final int currentIndex;
  final int totalItems;
  final String? author;
  final bool showCurrentPosition;

  const GalleryStatsWidget({
    Key? key,
    required this.currentIndex,
    required this.totalItems,
    this.author,
    this.showCurrentPosition = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (author != null && author!.isNotEmpty) Expanded(child: _authorCard(context, theme)),
        const Spacer(),
        if (showCurrentPosition) _positionIndicator(theme),
      ],
    );
  }

  Widget _authorCard(BuildContext context, ThemeData theme) {
    // final cardMaxWidth = size.width * 0.6;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black.withOpacity(0.55),
      ),
      // constraints: BoxConstraints(maxWidth: cardMaxWidth),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.camera_alt,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              author!,
              style: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }

  Widget _positionIndicator(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black.withOpacity(0.8),
      ),
      child: Row(
        children: [
          Text(
            "$currentIndex ",
            style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
          Text(
            "/ $totalItems",
            style: theme.textTheme.subtitle1?.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
