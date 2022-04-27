import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/models/restaurant.model.dart';
import 'package:xplore_bg_v2/presentation/location/location.screen.dart';
import 'package:xplore_bg_v2/presentation/restaurants/controllers/restaurant.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:auto_route/annotations.dart';

class RestaurantDetailsScreen extends ConsumerStatefulWidget {
  final RestaurantModel restaurant;
  final String id;

  const RestaurantDetailsScreen({
    Key? key,
    @PathParam() required this.id,
    required this.restaurant,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends ConsumerState<RestaurantDetailsScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(restaurantDetailsProvider(widget.restaurant.id));
    return details.when(
        loading: () => const Center(child: CircularProgressIndicator.adaptive()),
        error: (err, st) => Center(child: Text("$err")),
        data: (restaurant) {
          return LocationDetailsScreen(
            scrollController: _scrollController,
            location: restaurant!,
            slivers: [
              SliverToBoxAdapter(
                child: SectionWithTitleWidget(
                  title: const SectionTitleWithDividerWidget("Nearby"),
                  child: GalleryListViewWidget(gallery: restaurant.gallery!),
                ),
              ),
            ],
            bottomNavigationBar: ScrollToHideWidget(
              controller: _scrollController,
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
        });
  }
}
