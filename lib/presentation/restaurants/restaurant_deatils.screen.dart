import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/models/location/restaurant.model.dart';
import 'package:xplore_bg_v2/presentation/location/location.screen.dart';
import 'package:xplore_bg_v2/presentation/restaurants/controllers/restaurant.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:auto_route/annotations.dart';

class RestaurantDetailsScreen extends HookConsumerWidget {
  final RestaurantModel restaurant;
  final String id;
  final String heroTag;

  const RestaurantDetailsScreen({
    Key? key,
    @PathParam() required this.id,
    required this.restaurant,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(restaurantDetailsProvider(restaurant.id));

    final scrollController = useScrollController();

    return LocationDetailsScreen(
      scrollController: scrollController,
      location: restaurant,
      heroTag: heroTag,
      slivers: [
        SliverToBoxAdapter(
          child: LocationGallerySection(locationId: id, provider: restaurantDetailsProvider),
        ),
        const SliverToBoxAdapter(
          child: LoadingIndicator(
            indicatorType: Indicator.ballScaleMultiple,
            colors: [Colors.white, Colors.teal],
            strokeWidth: 2,
            pathBackgroundColor: Colors.black,
          ),
        ),
      ],
      bottomNavigationBar: ScrollToHideWidget(
        controller: scrollController,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Icon(Icons.heart_broken),
                Text("Likes"),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.bookmarks),
                Text("Bookmarks"),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.reviews_outlined),
                Text("Reviews"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
