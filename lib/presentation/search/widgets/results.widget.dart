import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/search/controllers/search.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class SearchResultsWidget extends ConsumerWidget {
  const SearchResultsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final results = ref.watch(paginatedPlaceSearchProvider);

    return PaginatedListViewWidget<PlaceModel>(
      provider: paginatedPlaceSearchProvider,
      emptyResultPlaceholder: BlankPage(
        icon: Icons.search_off_outlined,
        heading: LocaleKeys.no_places_found.tr(),
        shortText: LocaleKeys.no_places_found_desc.tr(),
      ),
      builder: (item) {
        return PlaceListTile(placePreview: item);
      },
    );
  }
}
