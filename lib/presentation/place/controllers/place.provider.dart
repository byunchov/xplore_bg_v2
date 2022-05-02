import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/gallery/gallery_loading.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/gallery/controllers/gallery.provider.dart';

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
      return place;
    }

    return null;
  },
);
