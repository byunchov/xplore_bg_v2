import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/models/image.model.dart';

class LocationModel {
  String id;
  String name;
  String? category;
  String? subcategory;
  String? region;
  String? residence;
  int? likesCount;
  int reviewsCount;
  double rating;
  LatLng? coordinates;
  ImageModel thumbnail;
  List<ImageModel>? gallery;

  LocationModel({
    required this.id,
    required this.name,
    this.category,
    this.subcategory,
    this.region,
    this.residence,
    this.likesCount,
    required this.reviewsCount,
    required this.rating,
    this.coordinates,
    required this.thumbnail,
    this.gallery,
  });
}
