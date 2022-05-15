import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/gallery/controllers/gallery.provider.dart';

final placeProvider = StateProvider.autoDispose.family<PlaceModel?, String>((ref, id) {
  return null;
});

final placeDetailsProvider = FutureProvider.autoDispose.family<PlaceModel?, String>(
  (ref, id) async {
    ref.onDispose(() {
      log("Disposed", name: "placeDetailsProvider($id)");
    });

    final searchRepo = ref.read(searcRepositoryProvider);
    final document = await searchRepo.getDocument("locations", "bg_$id");

    if (document != null) {
      final place = PlaceModel.formJson(document);
      // ref.read(galleryStateProvider(id).notifier).update((state) => place.gallery!);
      ref.read(galleryStateProvider(id).notifier).state = GalleryLoadingModel.data(place.gallery!);
      // ref.read(galleryStateProvider(id).state).state = place.gallery!;
      ref.read(placeProvider(id).state).state = place;

      return place;
    }

    return null;
  },
);

final placeNearbyLocationsProvider =
    FutureProvider.autoDispose.family<List<PlaceModel>, String>((ref, id) async {
  final repository = ref.read(searcRepositoryProvider);
  final place = ref.watch(placeProvider(id))!;
  final lang = ref.watch(appLocaleProvider).languageCode;

  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  await Future<void>.delayed(const Duration(milliseconds: 250));

  log("searcing more places", name: "nearbyPlacesProvider");

  final result = await repository.search(
    'locations',
    query: "",
    limit: 10,
    filter: ["lang=$lang", "loc_id!=$id"],
    sort: ["_geoPoint(${place.coordinates!.latitude}, ${place.coordinates!.longitude}):asc"],
    attributesToRetrieve: repository.previewAttributes,
  );
  final data = result.hits?.map((e) => PlaceModel.previewFromJson(e)).toList();

  return data ?? [];
});

final nearbyLocationsProvider = StateNotifierProvider.autoDispose
    .family<PaginationNotifier<PlaceModel>, PaginationState<PlaceModel>, String>((ref, id) {
  return PaginationNotifier<PlaceModel>(
      itemsPerBatch: 10,
      fetchNextItems: (item, {limit}) async {
        final repository = ref.watch(searcRepositoryProvider);

        final cancelToken = CancelToken();
        ref.onDispose(cancelToken.cancel);

        await Future<void>.delayed(const Duration(milliseconds: 250));

        log("searcing more places", name: "nearbyPlacesProvider");

        final result = await repository.search(
          'locations',
          query: "",
          limit: limit,
          offset: item?.offset,
          attributesToRetrieve: repository.previewAttributes,
        );
        final data = result.hits?.map((e) => PlaceModel.previewFromJson(e)).toList();

        return data ?? [];
      })
    ..init();
});
