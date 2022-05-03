import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/models/location/place.model.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/bookmarks.controller.dart';

class LikedLocationsScreen extends HookConsumerWidget {
  const LikedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(likedPlacesProvider.notifier);
      },
      child: PaginatedListViewWidget<PlaceModel>(
        provider: likedPlacesProvider,
        emptyResultPlaceholder: BlankPage(
          heading: LocaleKeys.no_favourites.tr(),
          shortText: LocaleKeys.no_favourites_desc.tr(),
          icon: Icons.bookmark_remove_rounded,
        ),
        errorPlaceholderBuilder: (err) => BlankPage(
          icon: Icons.error_outline_rounded,
          heading: "Error",
          shortText: err.toString(),
        ),
        builder: (item) {
          return PlaceListTile(placePreview: item);
        },
      ),
    );
  }
}
