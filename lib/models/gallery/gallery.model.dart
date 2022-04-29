import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/models/models.dart';

class GalleryModel {
  final List<ImageModel> items;
  final int itemCount;

  const GalleryModel(this.items) : itemCount = items.length;

  factory GalleryModel.formJson(List<Map<String, dynamic>> snap) {
    final gallery = snap.map<ImageModel>((e) => ImageModel.fromJson(e)).toList();
    return GalleryModel(gallery);
  }

  factory GalleryModel.fromGMaps(List<Map<String, dynamic>> snap) {
    // final gallery = snap.map<ImageModel>((e) => ImageModel.fromJson(e)).toList();
    final gallery = snap.map<ImageModel>((photo) {
      return ImageModel(
        url: GMapsUtils.getImageUrl(photo['photo_reference']),
        author: GMapsUtils.getSanitisedImageAuthor(photo['html_attributions'][0]),
      );
    }).toList();

    return GalleryModel(gallery);
  }
}
