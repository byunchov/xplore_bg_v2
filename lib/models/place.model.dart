import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/models/image.model.dart';
import 'package:xplore_bg_v2/models/location.model.dart';

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
    List<ImageModel>? gallery,
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
      gallery: List<Map>.from(snapshot['gallery'])
          .map((e) => ImageModel(url: e['url'], author: e['author']))
          .toList(),
    );
  }
}
/* 
class PlaceModel {
  final String id;
  final String name;
  final String? category;
  final String? subcategory;
  final String? region;
  final String? residence;
  final int? likesCount;
  final int? reviewsCount;
  final double? rating;
  final LatLng? coordinates;
  final String? description;
  final ImageModel thumbnail;
  final List<ImageModel>? gallery;

  PlaceModel({
    required this.id,
    required this.name,
    this.category,
    this.subcategory,
    this.region,
    this.residence,
    this.likesCount,
    this.reviewsCount,
    this.rating,
    this.coordinates,
    this.description,
    required this.thumbnail,
    this.gallery,
  });

  factory PlaceModel.previewFromJson(Map<String, dynamic> snapshot) {
    return PlaceModel(
      id: snapshot['id'] as String,
      name: snapshot['name'] as String,
      category: snapshot['category'] as String,
      subcategory: snapshot['subcategory'] as String,
      residence: snapshot['residence'] as String,
      region: snapshot['region'] as String,
      thumbnail: ImageModel(url: snapshot['thumbnail'] as String),
      likesCount: snapshot['like_count'] as int,
      reviewsCount: snapshot['review_count'] as int,
      rating: snapshot['rating'].toDouble(),
      coordinates: LatLng(snapshot['_geo']["lat"], snapshot['_geo']["lng"]),
    );
  }

  factory PlaceModel.formJson(Map<String, dynamic> snapshot) {
    return PlaceModel(
      id: snapshot['id'] as String,
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
      gallery: List<String>.from(snapshot['gallery'])
          .map((e) => ImageModel(url: e, author: "Author"))
          .toList(),
    );
  }
}
 */

class PlacePreview {
  final String id;
  final String name;
  final String? category;
  final String? subcategory;
  final String? region;
  final String? residence;
  final String? thumbnail;
  final int? likesCount;
  final int? reviewsCount;
  final double? rating;
  final LatLng? coordinates;

  PlacePreview({
    required this.id,
    required this.name,
    this.category,
    this.subcategory,
    this.region,
    this.residence,
    this.thumbnail,
    this.likesCount,
    this.reviewsCount,
    this.rating,
    this.coordinates,
  });

  factory PlacePreview.fromJson(Map<String, dynamic> snapshot) {
    return PlacePreview(
      id: snapshot['id'] as String,
      name: snapshot['name'] as String,
      category: snapshot['category'] as String,
      subcategory: snapshot['subcategory'] as String,
      residence: snapshot['residence'] as String,
      region: snapshot['region'] as String,
      thumbnail: snapshot['thumbnail'] as String,
      likesCount: snapshot['like_count'] as int,
      reviewsCount: snapshot['review_count'] as int,
      rating: snapshot['rating'].toDouble(),
      coordinates: LatLng(snapshot['_geo']["lat"], snapshot['_geo']["lng"]),
    );
  }
}
