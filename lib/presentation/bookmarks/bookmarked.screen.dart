import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/bookmarks.controller.dart';

class BookmarkedLocationsScreen extends ConsumerWidget {
  const BookmarkedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const field = "bookmarks";

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(notedPlacesProvider(field).notifier);
      },
      child: PaginatedListViewWidget<PlaceModel>(
        provider: notedPlacesProvider(field),
        emptyResultPlaceholder: BlankPage(
          heading: LocaleKeys.no_bookmarks.tr(),
          shortText: LocaleKeys.no_bookmarks_desc.tr(),
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
