import 'dart:typed_data';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/gallery/controllers/gallery.provider.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/maps.provider.dart';

final lodgingListProvider =
    FutureProvider.autoDispose.family<List<RestaurantModel>, LatLng>((ref, coordinates) async {
  final mapsRepo = ref.read(mapsPlaceRepositoryProvider);
  final response = await mapsRepo.getNearbyPlaces(coordinates, GMapsPlaceType.lodging);
  final restaurants = response.map((e) => RestaurantModel.previewFromJson(e)).toList();

  return restaurants;
});

final lodgingDetailsProvider =
    FutureProvider.autoDispose.family<RestaurantModel, String>((ref, id) async {
  final mapsRepo = ref.read(mapsPlaceRepositoryProvider);
  final response = await mapsRepo.getPlaceDetails(id);
  final restaurant = RestaurantModel.formJson(response, id);
  ref.read(galleryStateProvider(id).notifier).state = GalleryLoadingModel.data(restaurant.gallery!);

  return restaurant;
});
