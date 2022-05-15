import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/models/location/place.model.dart';
import 'package:xplore_bg_v2/presentation/explore/controllers/explore.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class ShowMoreNearbyScreen extends HookConsumerWidget {
  const ShowMoreNearbyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitleWidget(
          title: LocaleKeys.section_nearby.tr(),
          leading: AppbarActionWidget(
            iconData: Icons.arrow_back,
            buttonSize: 42,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(locationsNearbyProvider);
        },
        child: PaginatedListViewWidget<PlaceModel>(
          provider: locationsNearbyProvider,
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
            return PlaceListTile(placePreview: item, showDistance: true);
          },
        ),
      ),
    );
  }
}
