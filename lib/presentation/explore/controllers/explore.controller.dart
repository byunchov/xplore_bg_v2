// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/providers/location.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/search/controllers/search.controller.dart';

enum LocationSortType {
  rating, // popular
  review_count, // visited
  like_count, // liked
}

final locationSortTypeProvider =
    StateProvider.autoDispose<LocationSortType>((ref) => LocationSortType.rating);

final locationSortProvider = FutureProvider.autoDispose<List<PlaceModel>>((ref) async {
  final sortType = ref.watch(locationSortTypeProvider);
  final lang = ref.watch(appLocaleProvider).languageCode;
  final repository = ref.watch(searcRepositoryProvider);

  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  await Future<void>.delayed(const Duration(milliseconds: 250));
  if (cancelToken.isCancelled) throw AbortedException();

  final result = await repository.search(
    'locations',
    query: "",
    limit: 5,
    filter: ["lang = $lang"],
    sort: ["${sortType.name}:desc"],
    attributesToRetrieve: repository.previewAttributes,
  );
  final data = result.hits?.map((e) => PlaceModel.previewFromJson(e)).toList();

  return data ?? [];
});
/* 
final locationsNearbyProvider = FutureProvider.autoDispose<List<PlaceModel>>((ref) async {
  final lang = ref.watch(appLocaleProvider).languageCode;
  final repository = ref.watch(searcRepositoryProvider);
  final location = ref.watch(locationProvider).value;

  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  await Future<void>.delayed(const Duration(milliseconds: 250));
  if (cancelToken.isCancelled) throw AbortedException();

  if (location == null) return [];

  final result = await repository.search(
    'locations',
    query: "",
    limit: 10,
    filter: ["lang = $lang"],
    sort: ["_geoPoint(${location.latitude},${location.longitude}):asc"],
    attributesToRetrieve: repository.previewAttributes,
  );
  final data = result.hits?.map((e) => PlaceModel.previewFromJson(e)).toList();

  return data ?? [];
}); 
*/

final locationsNearbyProvider =
    StateNotifierProvider<PaginationNotifier<PlaceModel>, PaginationState<PlaceModel>>((ref) {
  final userLocation = ref.watch(locationProvider);
  return PaginationNotifier<PlaceModel>(
      itemsPerBatch: 10,
      fetchNextItems: (item, {limit}) async {
        final repository = ref.read(searcRepositoryProvider);
        final location = userLocation.value;

        final cancelToken = CancelToken();
        ref.onDispose(cancelToken.cancel);

        await Future<void>.delayed(const Duration(milliseconds: 250));
        if (cancelToken.isCancelled) throw AbortedException();

        if (location == null) {
          return [];
        }

        final result = await repository.search(
          'locations',
          query: "",
          limit: limit,
          offset: item?.offset,
          sort: ["_geoPoint(${location.latitude},${location.longitude}):asc"],
          attributesToRetrieve: repository.previewAttributes,
        );
        final data = result.hits?.map((e) => PlaceModel.previewFromJson(e)).toList();

        return data ?? [];
      })
    ..init();
});

final featurePlacesProvider = FutureProvider<List<PlaceModel>>((ref) async {
  final firestore = ref.read(firebaseFirestoreProvider);
  final searchRepo = ref.read(searcRepositoryProvider);
  final lang = ref.watch(appLocaleProvider).languageCode;

  final featured =
      await firestore.collection('featured').orderBy("created_at", descending: true).limit(1).get();
  final docs = featured.docs;
  if (docs.isNotEmpty) {
    final doc = docs.first;
    List<PlaceModel> locations = [];
    for (var item in doc['locations']) {
      final snap = await searchRepo.getDocument("locations", "${lang}_$item");
      if (snap != null) {
        locations.add(PlaceModel.previewFromJson(snap));
      }
    }
    return locations;
  }
  return [];
});
