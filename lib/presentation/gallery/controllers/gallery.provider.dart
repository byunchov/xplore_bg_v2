import 'dart:developer';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/models/gallery/gallery_loading.dart';

/* final galleryStateProvider = StateProvider.autoDispose.family<GalleryModel, String>((ref, id) {
  // return throw UnimplementedError("galleryStateProvider");
  ref.onDispose(() {
    log("Disposed", name: "galleryStateProvider($id)");
  });

  return GalleryModel([], locId: id);
}); */

final galleryStateProvider =
    StateProvider.autoDispose.family<GalleryLoadingModel, String>((ref, id) {
  ref.onDispose(() {
    log("Disposed", name: "galleryStateProvider($id)");
  });
  return const GalleryLoadingModel.loading();
});
