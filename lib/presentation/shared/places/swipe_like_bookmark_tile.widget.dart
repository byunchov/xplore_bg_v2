import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/models/swipe_action.model.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/note_action.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PlaceLikeBookmarkSwipeListTile extends ConsumerWidget {
  const PlaceLikeBookmarkSwipeListTile({
    Key? key,
    required this.place,
  }) : super(key: key);
  final PlaceModel place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlaceSwipeListTile(
      placePreview: place,
      actions: [
        SwipeActionModel(
          child: SwipeActionButton(
            id: place.id,
            field: 'bookmark_count',
            iconStyle: BookmarkIcon(colorBold: Colors.white),
            color: Colors.blue,
          ),
          onTap: () async {
            await ref.read(bookmarkLocationProvider).bookmarkLocation(
              place.id,
              onSuccess: (noted) {
                SnackbarUtils.showSnackBar(
                  context,
                  snackBarType: SnackBarType.info,
                  message: (noted ? LocaleKeys.favourite_added : LocaleKeys.favourite_removed)
                      .tr(namedArgs: {'name': place.name}),
                );
              },
            );
          },
        ),
        SwipeActionModel(
          child: SwipeActionButton(
            id: place.id,
            field: 'like_count',
            iconStyle: LikeIcon(colorBold: Colors.white),
            color: Colors.red,
          ),
          onTap: () async {
            await ref.read(bookmarkLocationProvider).likeLocation(
              place.id,
              onSuccess: (noted) {
                SnackbarUtils.showSnackBar(
                  context,
                  snackBarType: SnackBarType.info,
                  message: (noted ? LocaleKeys.favourite_added : LocaleKeys.favourite_removed)
                      .tr(namedArgs: {'name': place.name}),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
