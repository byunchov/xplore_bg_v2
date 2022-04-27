import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/location.model.dart';
import 'package:xplore_bg_v2/models/restaurant.model.dart';
import 'package:xplore_bg_v2/presentation/restaurants/restaurant_deatils.screen.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/restaurant.provider.dart';

class RestaurantsScreen extends ConsumerWidget {
  final LocationModel location;
  const RestaurantsScreen(this.location, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurantList = ref.watch(restaurantsListProvider(location.coordinates!));

    print(context.router.routeData.path);
    print(context.router.routeData.pathParams);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FlutterMap(
              options: MapOptions(
                center: location.coordinates,
                zoom: 15,
                maxZoom: 18,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"),
                MarkerLayerOptions(markers: [
                  Marker(
                    point: location.coordinates!,
                    builder: (ctx) => InkWell(
                      child: Image.asset(AppConfig.restaurantPinIcon),
                      onTap: () {},
                    ),
                    height: 60,
                    width: 60,
                  )
                ]),
              ],
            ),
          ),
          GalleryOverlayWidgets.backButtonAndTitleOverlay(context, "Restaurants"),
          Positioned(
            bottom: 20.0,
            child: SizedBox(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              child: restaurantList.when(
                loading: () => const CircularProgressIndicator.adaptive(),
                error: (err, st) => Text("$err"),
                data: (data) => CarouselSliderWidget(
                  autoPlay: false,
                  showIndicator: false,
                  viewportFraction: 0.9,
                  children: data.map((e) => MapCardWidget(location: e)).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapCardWidget extends StatelessWidget {
  final RestaurantModel location;
  const MapCardWidget({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardRadius = WidgetConstants.kCradBorderRadius;
    const double cardHeight = 220;

    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(cardRadius),
      color: theme.listTileTheme.tileColor,
      elevation: 4,
      child: InkWell(
        onTap: () {
          print(context.router.current.meta);
          context.router.push(RestaurantDetailsRoute(id: location.id, restaurant: location));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: cardHeight * 0.6,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(cardRadius),
                  topRight: Radius.circular(cardRadius),
                ),
                child: CustomCachedImage(
                  imageUrl: location.thumbnail.url,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      location.name,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.grey,
                          size: 15,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            location.residence!,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.5,
                            ),
                            // style: TextStyle(
                            //   color: Colors.grey[700],
                            //   fontWeight: FontWeight.w400,
                            //   fontSize: 12.5,
                            // ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: location.rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.zero,
                          itemSize: 18,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                        Container(width: 5),
                        Text(
                          '${location.rating} (${location.reviewsCount}) ${location.category}',
                          // style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                          style: theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
