import 'dart:typed_data';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/gallery/controllers/gallery.provider.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/maps.provider.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/place.provider.dart';

final gmapsPlaceListProvider = FutureProvider.autoDispose
    .family<List<GMapsPlaceModel>, LocationIdentifierModel>((ref, identity) async {
  final location = ref.watch(placeDetailsProvider(identity.id)).value;
  final mapsRepo = ref.read(mapsPlaceRepositoryProvider);

  final response = await mapsRepo.getNearbyPlaces(location!.coordinates!, identity.type);
  final gPlaces = response.map((e) => GMapsPlaceModel.previewFromJson(e)).toList();

  return gPlaces;
});

final gmapsPlaceDetailsProvider =
    FutureProvider.autoDispose.family<GMapsPlaceModel, String>((ref, id) async {
  // final _ = ref.watch(galleryStateProvider(id));

  final mapsRepo = ref.read(mapsPlaceRepositoryProvider);
  final response = await mapsRepo.getPlaceDetails(id);
  final gPlace = GMapsPlaceModel.formJson(response, id);
  ref.read(galleryStateProvider(id).notifier).state = GalleryLoadingModel.data(gPlace.gallery!);

  return gPlace;
});

final lodgingPinBitmapProvider = Provider<Uint8List>((ref) {
  return Uint8List(0);
});

final restaurantPinBitmapProvider = Provider<Uint8List>((ref) {
  return Uint8List(0);
});
