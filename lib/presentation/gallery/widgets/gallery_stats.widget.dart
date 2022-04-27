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
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black.withOpacity(0.55),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 15,
              ),
              const SizedBox(width: 6),
              Text(
                author ?? "Author $currentIndex",
                style: theme.textTheme.labelMedium?.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
        const Spacer(),
        showCurrentPosition
            ? Container(
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
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
