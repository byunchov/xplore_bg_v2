import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/models/location/place.model.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/bookmarks.controller.dart';

class LikedLocationsScreen extends HookConsumerWidget {
  const LikedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const field = "likes";
    final user = ref.watch(authControllerProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(notedPlacesProvider(field));
      },
      child: user != null
          ? PaginatedListViewWidget<PlaceModel>(
              provider: notedPlacesProvider(field),
              emptyResultPlaceholder: BlankPage(
                heading: LocaleKeys.no_favourites.tr(),
                shortText: LocaleKeys.no_favourites_desc.tr(),
                icon: Icons.bookmark_remove_rounded,
              ),
              errorPlaceholderBuilder: (err) => BlankPage(
                icon: Icons.error_outline_rounded,
                heading: LocaleKeys.error_title.tr(),
                shortText: err.toString(),
              ),
              builder: (item) {
                return PlaceListTile(placePreview: item);
              },
            )
          : const UserNotLoggedInWidget(),
    );
  }
}
