import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/models/models.dart';

class RestaurantModel extends LocationModel {
  String? mapsUrl;
  String? phoneNumber;
  List<String>? openingHours;

  RestaurantModel({
    required String id,
    required String name,
    String? category,
    String? subcategory = LocaleKeys.tag_restaurant,
    String? region,
    String? residence,
    int? likesCount,
    required int reviewsCount,
    required double rating,
    LatLng? coordinates,
    required ImageModel thumbnail,
    GalleryModel? gallery,
    this.mapsUrl,
    this.phoneNumber,
    this.openingHours,
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

  factory RestaurantModel.previewFromJson(Map<String, dynamic> snapshot) {
    return RestaurantModel(
      id: snapshot['place_id'] as String,
      name: snapshot['name'] as String,
      category: GMapsUtils.getPriceLevel(snapshot['price_level']),
      residence: snapshot['vicinity'] as String,
      thumbnail: ImageModel(url: GMapsUtils.getThumbnail(snapshot['photos'], snapshot)),
      reviewsCount: snapshot['user_ratings_total'] as int? ?? 0,
      rating: snapshot['rating']?.toDouble() ?? 0,
      coordinates:
          LatLng(snapshot['geometry']['location']['lat'], snapshot['geometry']['location']["lng"]),
    );
  }

  factory RestaurantModel.formJson(Map<String, dynamic> snapshot, String id) {
    // debugPrint(snapshot.toString());
    return RestaurantModel(
      id: snapshot['place_id'] ?? id,
      name: snapshot['name'] as String,
      category: GMapsUtils.getPriceLevel(snapshot['price_level']),
      residence: snapshot['formatted_address'] as String,
      thumbnail: ImageModel(url: GMapsUtils.getThumbnail(snapshot['photos'], snapshot)),
      reviewsCount: snapshot['user_ratings_total'] as int? ?? 0,
      rating: snapshot['rating']?.toDouble() ?? 0,
      coordinates: LatLng(
        snapshot['geometry']['location']['lat'] ?? 0,
        snapshot['geometry']['location']["lng"] ?? 0,
      ),
      gallery: GalleryModel.fromGMaps(List<Map<String, dynamic>>.from(snapshot['photos'])),
      phoneNumber: snapshot['international_phone_number'],
      mapsUrl: snapshot['url'],
      openingHours: GMapsUtils.getOpeningHours(snapshot['opening_hours']),
    );
  }
}
