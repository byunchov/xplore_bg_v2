import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/note_action.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PlaceActionDialog extends ConsumerWidget {
  const PlaceActionDialog({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  final String id;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Center(
      child: Container(
        width: size.width * 0.8,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.dialogTheme.backgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NotedActionIconButton(
                  id: id,
                  field: 'like_count',
                  iconStyle: LikeIcon(),
                  onPressed: () async {
                    await ref.read(bookmarkLocationProvider).likeLocation(id);
                  },
                ),
                // const SizedBox(width: 64),
                NotedActionIconButton(
                  id: id,
                  field: 'bookmark_count',
                  iconStyle: BookmarkIcon(),
                  onPressed: () async {
                    await ref.read(bookmarkLocationProvider).bookmarkLocation(id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
