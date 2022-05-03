import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/gmaps.provider.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/place.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class GMapsLisitngWidget extends ConsumerStatefulWidget {
  final LocationIdentifierModel locId;
  final String heading;

  const GMapsLisitngWidget({
    Key? key,
    required this.locId,
    required this.heading,
  }) : super(key: key);

  @override
  ConsumerState<GMapsLisitngWidget> createState() => _GMapsLisitngWidgetState();
}

class _GMapsLisitngWidgetState extends ConsumerState<GMapsLisitngWidget> {
  final PageController _carouselController = PageController(viewportFraction: 0.9);
  GoogleMapController? _mapsController;
  BitmapDescriptor? _markerIcon;
  final Set<Marker> _markers = {};

  late PlaceModel _location;

  @override
  void initState() {
    setState(() {
      _location = ref.read(placeDetailsProvider(widget.locId.id)).value!;
    });
    final provider = widget.locId.type == GMapsPlaceType.restaurant
        ? restaurantPinBitmapProvider
        : lodgingPinBitmapProvider;

    final bitmap = ref.read(provider);
    _markerFromBitmap(bitmap);
    _addLocationMarker();

    super.initState();
  }

  @override
  void dispose() {
    _mapsController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final restaurantList = ref.watch(gmapsPlaceListProvider(widget.locId));

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
                  _location.coordinates!.latitude,
                  _location.coordinates!.longitude,
                ),
                zoom: 14.3,
              ),
              markers: _markers,
              onMapCreated: _onMapCreated,
            ),
          ),
          GalleryOverlayWidgets.backButtonAndTitleOverlay(context, widget.heading),
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
                    controller: _carouselController,
                    children: data.map((e) => MapCardWidget(place: e)).toList(),
                    onPageChanged: _animateCameraToPosition,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      _mapsController = controllerParam;
    });
  }

  void _markerFromBitmap(Uint8List bitmap) {
    setState(() {
      _markerIcon = BitmapDescriptor.fromBytes(bitmap);
    });
  }

  void _addLocationMarker() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_location.id),
          position: LatLng(_location.coordinates!.latitude, _location.coordinates!.longitude),
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {},
        ),
      );
    });
  }

  void _addMarkers(List<GMapsPlaceModel> data) {
    final markers = data.map<Marker>((location) {
      final position = LatLng(location.coordinates!.latitude, location.coordinates!.longitude);
      return Marker(
        markerId: MarkerId(location.id),
        position: position,
        infoWindow: InfoWindow(
          title: location.name,
          snippet: location.residence,
          onTap: () {
            context.router.push(GMapsDetailsRoute(
              id: location.id,
              place: location,
              heroTag: location.id,
            ));
          },
        ),
        icon: _markerIcon ?? BitmapDescriptor.defaultMarker,
        onTap: () {
          final index = _markers.toList().indexWhere((element) => element.position == position);
          _carouselController.jumpToPage(index - 1);
        },
      );
    });

    setState(() {
      _markers.addAll(markers);
    });
  }

  void _animateCameraToPosition(int index) {
    final marker = _markers.elementAt(index + 1);
    _mapsController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: marker.position,
          zoom: 20,
          bearing: 45.0,
          tilt: 45.0,
        ),
      ),
    );
  }
}

class MapCardWidget extends StatelessWidget {
  final GMapsPlaceModel place;
  const MapCardWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardRadius = WidgetConstants.kCradBorderRadius;
    const double cardHeight = 220;
    // final heroTag = UniqueKey().toString();
    final heroTag = place.id;

    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(cardRadius),
      color: theme.listTileTheme.tileColor,
      elevation: 4,
      child: InkWell(
        onTap: () {
          print(context.router.current.meta);
          context.router.push(GMapsDetailsRoute(id: place.id, heroTag: heroTag, place: place));
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
                    imageUrl: place.thumbnail.url,
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
                      place.name,
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
                            place.residence!,
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
                          initialRating: place.rating,
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
                          '${place.rating} (${place.reviewsCount}) ${place.category}',
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
