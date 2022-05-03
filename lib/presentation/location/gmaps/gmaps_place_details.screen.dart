import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/location/location.screen.dart';
import 'package:xplore_bg_v2/presentation/shared/location/gmaps/detail_section.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/location/gmaps/review_section.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class GMapsDetailsScreen extends HookConsumerWidget {
  final GMapsPlaceModel place;
  final String id;
  final String heroTag;

  const GMapsDetailsScreen({
    Key? key,
    @PathParam() required this.id,
    required this.place,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final details = ref.watch(lodgingDetailsProvider(restaurant.id));

    final scrollController = useScrollController();

    return LocationDetailsScreen(
      scrollController: scrollController,
      location: place,
      heroTag: heroTag,
      slivers: [
        SliverToBoxAdapter(
          child: LocationGallerySection(locationId: id),
        ),
        SliverToBoxAdapter(
          child: DetailSectionWidget(id),
        ),
        SliverToBoxAdapter(
          child: ReviewSectionWidget(id),
        ),
      ],
    );
  }
}
