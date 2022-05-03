import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/typedef.util.dart';
import 'package:xplore_bg_v2/models/models.dart';

class GMapsPlaceModel extends LocationModel {
  final String? mapsUrl;
  final String? phoneNumber;
  final List<String>? openingHours;
  final String? website;
  final List<ReviewModel>? reviews;

  GMapsPlaceModel({
    required String id,
    required String name,
    String? category,
    String? subcategory,
    String? residence,
    required int reviewsCount,
    required double rating,
    LatLng? coordinates,
    required ImageModel thumbnail,
    GalleryModel? gallery,
    this.mapsUrl,
    this.phoneNumber,
    this.openingHours,
    this.website,
    this.reviews,
  }) : super(
            id: id,
            name: name,
            category: category,
            subcategory: subcategory,
            residence: residence,
            reviewsCount: reviewsCount,
            rating: rating,
            coordinates: coordinates,
            thumbnail: thumbnail,
            gallery: gallery);

  GMapsPlaceModel copyWith({
    String? id,
    String? name,
    double? rating,
    int? reviewsCount,
    ImageModel? thumbnail,
    String? mapsUrl,
    String? phoneNumber,
    List<String>? openingHours,
    String? website,
    List<ReviewModel>? reviews,
  }) {
    return GMapsPlaceModel(
      id: id ?? this.id,
      name: '',
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      thumbnail: thumbnail ?? this.thumbnail,
      mapsUrl: mapsUrl ?? this.mapsUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      openingHours: openingHours ?? this.openingHours,
      website: website ?? this.website,
      reviews: reviews ?? this.reviews,
    );
  }

  factory GMapsPlaceModel.previewFromJson(Map<String, dynamic> snapshot) {
    return GMapsPlaceModel(
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

  factory GMapsPlaceModel.formJson(JsonMap snapshot, String id) {
    // debugPrint(snapshot.toString());
    final _id = snapshot['place_id']?.toString() ?? id;
    return GMapsPlaceModel(
      id: _id,
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
      gallery: GalleryModel.fromGMaps(JsonListMap.from(snapshot['photos'] ?? []), _id),
      phoneNumber: snapshot['international_phone_number'],
      mapsUrl: snapshot['url'],
      openingHours: GMapsUtils.getOpeningHours(snapshot['opening_hours']),
      website: snapshot['website'] as String?,
      reviews: JsonListMap.from(snapshot['reviews'] ?? [])
          .map<ReviewModel>((review) => ReviewModel.fromGMaps(review))
          .toList()
        ..sort((a, b) => a.rating.compareTo(b.rating))
        ..reversed.toList(),
    );
  }

  @override
  String toString() {
    return 'GMapsPlaceModel(mapsUrl: $mapsUrl, phoneNumber: $phoneNumber, openingHours: $openingHours, website: $website, reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GMapsPlaceModel &&
        other.mapsUrl == mapsUrl &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.openingHours, openingHours) &&
        other.website == website &&
        listEquals(other.reviews, reviews);
  }

  @override
  int get hashCode {
    return mapsUrl.hashCode ^
        phoneNumber.hashCode ^
        openingHours.hashCode ^
        website.hashCode ^
        reviews.hashCode;
  }
}
