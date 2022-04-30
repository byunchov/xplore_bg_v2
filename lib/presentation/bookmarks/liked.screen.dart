import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/infrastructure/pagination/pagination_notifier.dart';
import 'package:xplore_bg_v2/models/pagination/pagination_state.model.dart';
import 'package:xplore_bg_v2/models/location/place.model.dart';
// import 'package:xplore_bg_v2/presentation/shared/pagination/paginated_list_view.widget%20copy%202.dart';
import 'package:xplore_bg_v2/presentation/shared/pagination/paginated_list_view.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/bookmarks.controller.dart';

class LikedLocationsScreen extends HookConsumerWidget {
  const LikedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(likedProvider.notifier);
      },
      child: PaginatedListViewWidget<PlaceModel>(
        provider: likedProvider,
        loadingPlaceholder: const Center(child: CircularProgressIndicator()),
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
