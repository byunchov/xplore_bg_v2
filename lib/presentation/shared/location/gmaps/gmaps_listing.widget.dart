import 'dart:typed_data';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
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
          Positioned(
            bottom: 20.0,
            child: SizedBox(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              child: restaurantList.when(
                loading: () {
                  return const FeaturedLoadingCardWidget();
                },
                error: (error, stackTrace) {
                  final message = error is Failure ? error.message.tr() : error.toString();

                  return BlankSectionWidget(
                    message: message.tr(),
                    icon: Icons.location_on_outlined,
                  );
                },
                data: (data) {
                  _addMarkers(data);
                  return CarouselSliderWidget(
                    controller: _carouselController,
                    children: data.map((e) => MapCardWidget(place: e)).toList(),
                    onPageChanged: _animateCameraToPosition,
                  );
                },
              ),
            ),
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
