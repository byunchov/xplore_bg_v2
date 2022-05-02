import 'dart:developer';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/location/location.model.dart';
import 'package:xplore_bg_v2/models/location/restaurant.model.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/restaurants.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantsScreen extends ConsumerStatefulWidget {
  final LocationModel location;
  const RestaurantsScreen(this.location, {Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends ConsumerState<RestaurantsScreen> {
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;
  List<Marker> _markers = [];

  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 0), _markerFromAsset);
    // _markerFromAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantList = ref.watch(restaurantsListProvider(widget.location.coordinates!));
    // _createMarkerImageFromAsset(context);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: GoogleMap(
              compassEnabled: false,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.location.coordinates!.latitude,
                  widget.location.coordinates!.longitude,
                ),
                zoom: 14,
              ),
              markers: Set.from(_markers),
              onMapCreated: _onMapCreated,
            ),
          ),
          GalleryOverlayWidgets.backButtonAndTitleOverlay(context, "Restaurants"),
          restaurantList.when(
            loading: () {
              return Align(
                alignment: Alignment.center,
                child: SizedBox.square(
                  dimension: 128,
                  child: LoadingIndicator(
                    colors: [Colors.cyan[700]!, Colors.cyan[400]!],
                    strokeWidth: 8,
                    indicatorType: Indicator.ballRotateChase,
                  ),
                ),
              );
            },
            error: (err, st) => Text("$err"),
            data: (data) {
              _addMarkers(data);
              return Positioned(
                bottom: 20.0,
                child: SizedBox(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSliderWidget(
                    autoPlay: false,
                    showIndicator: false,
                    viewportFraction: 0.9,
                    children: data.map((e) => MapCardWidget(location: e)).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _createMarkerImageFromAsset(BuildContext context) {
    final ImageConfiguration imageConfiguration =
        createLocalImageConfiguration(context, size: const Size.square(48));
    BitmapDescriptor.fromAssetImage(imageConfiguration, AppConfig.restaurantPinIcon)
        .then(_updateBitmap);
  }

  void _markerFromAsset() async {
    final marker = await GMapsUtils.getBytesFromAsset(AppConfig.restaurantPinIcon, 95);
    setState(() {
      _markerIcon = BitmapDescriptor.fromBytes(marker);
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _addMarkers(List<LocationModel> data) {
    final markers = data.map<Marker>((location) {
      return Marker(
        markerId: MarkerId(location.id),
        position: LatLng(location.coordinates!.latitude, location.coordinates!.longitude),
        infoWindow: InfoWindow(title: location.name, snippet: location.residence),
        icon: _markerIcon ?? BitmapDescriptor.defaultMarker,
        onTap: () {},
      );
    }).toList();

    setState(() {
      _markers = markers;
    });
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
    final heroTag = UniqueKey().toString();

    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(cardRadius),
      color: theme.listTileTheme.tileColor,
      elevation: 4,
      child: InkWell(
        onTap: () {
          print(context.router.current.meta);
          context.router.push(
              RestaurantDetailsRoute(id: location.id, restaurant: location, heroTag: heroTag));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: cardHeight * 0.6,
              child: Hero(
                tag: heroTag,
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
