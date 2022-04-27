import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/models/models.dart';

class RestaurantModel extends LocationModel {
  String? mapsUrl;
  String? phoneNumber;
  List<String>? openingHours;

  RestaurantModel({
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
    List<ImageModel>? gallery,
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
      category: _getPriceLevel(snapshot['price_level']),
      residence: snapshot['vicinity'] as String,
      thumbnail: ImageModel(url: _getThumbnail(snapshot['photos'], snapshot)),
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
      category: _getPriceLevel(snapshot['price_level']),
      residence: snapshot['formatted_address'] as String,
      thumbnail: ImageModel(url: _getThumbnail(snapshot['photos'], snapshot)),
      reviewsCount: snapshot['user_ratings_total'] as int? ?? 0,
      rating: snapshot['rating']?.toDouble() ?? 0,
      coordinates:
          LatLng(snapshot['geometry']['location']['lat'], snapshot['geometry']['location']["lng"]),
      gallery: List.from(snapshot['photos'])
          .map(
            (p) => ImageModel(
              url: _getImageUrl(p['photo_reference']),
              author: _removeEscapedHtml(_removeHtmlTags(p['html_attributions'][0])),
            ),
          )
          .toList(),
      phoneNumber: snapshot['international_phone_number'],
      mapsUrl: snapshot['url'],
      openingHours: _getOpeningHours(snapshot['opening_hours']),
    );
  }

  static String _removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static String _removeEscapedHtml(String htmlText) {
    RegExp exp = RegExp(r"&[^;]*;", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static String _getThumbnail(List? photos, Map<String, dynamic> snapshot) {
    if (photos == null) {
      return snapshot['icon'] as String;
    } else {
      return _getImageUrl(photos[0]['photo_reference']);
    }
  }

  static String _getImageUrl(String photo) {
    const mapAPIKey = AppConfig.mapsAPIKey;
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=600"
        "&photoreference=$photo&key=$mapAPIKey";
  }

  static String _getPriceLevel(dynamic priceLevel) {
    if (priceLevel == null) {
      return '---';
    }

    int pl = priceLevel.toInt();
    if (pl == 0) {
      return 'Free';
    } else {
      return '\$' * pl;
    }
  }

  static List<String> _getOpeningHours(dynamic opening) {
    return opening == null ? [] : List<String>.from(opening['weekday_text'] ?? []);
  }
}
