import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/models/models.dart';

class PlaceModel extends LocationModel {
  String? description;
  PlaceModel({
    required String id,
    required String name,
    String? category,
    String? subcategory,
    String? region,
    String? residence,
    int? likesCount,
    required int reviewsCount,
    required double rating,
    LatLng? coordinates,
    required ImageModel thumbnail,
    this.description,
    GalleryModel? gallery,
  }) : super(
          id: id,
          name: name,
          category: category,
          subcategory: subcategory,
          region: region,
          residence: residence,
          likesCount: likesCount,
          reviewsCount: reviewsCount,
          rating: rating,
          coordinates: coordinates,
          thumbnail: thumbnail,
          gallery: gallery,
        );

  factory PlaceModel.previewFromJson(Map<String, dynamic> snapshot) {
    return PlaceModel(
      id: snapshot['loc_id'] as String,
      name: snapshot['name'] as String,
      category: snapshot['category'] as String,
      subcategory: snapshot['subcategory'] as String,
      residence: snapshot['residence'] as String,
      region: snapshot['region'] as String?,
      thumbnail: ImageModel(url: snapshot['thumbnail'] as String),
      likesCount: snapshot['like_count'] as int,
      reviewsCount: snapshot['review_count'] as int,
      rating: snapshot['rating'].toDouble(),
      coordinates: LatLng(snapshot['_geo']["lat"], snapshot['_geo']["lng"]),
    );
  }

  factory PlaceModel.formJson(Map<String, dynamic> snapshot) {
    return PlaceModel(
      id: snapshot['loc_id'] as String,
      name: snapshot['name'] as String,
      category: snapshot['category'] as String,
      subcategory: snapshot['subcategory'] as String,
      residence: snapshot['residence'] as String,
      region: snapshot['region'] as String,
      description: snapshot['description'] as String,
      thumbnail: ImageModel(url: snapshot['thumbnail'] as String),
      likesCount: snapshot['like_count'] as int,
      reviewsCount: snapshot['review_count'] as int,
      rating: snapshot['rating'].toDouble(),
      coordinates: LatLng(snapshot['_geo']["lat"], snapshot['_geo']["lng"]),
      gallery: GalleryModel.formJson(List<Map<String, dynamic>>.from(snapshot['gallery'])),
    );
  }
}
