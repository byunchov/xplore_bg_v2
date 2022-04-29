import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/utils/escape_html.util.dart';

enum GMapsPlaceType {
  restaurant,
  lodging,
}

class GMapsUtils {
  static String get mapsAPIKey => dotenv.env['MAPS_API_KEY']!;

  static String getThumbnail(List? photos, Map<String, dynamic> snapshot) {
    if (photos == null) {
      return snapshot['icon'] as String;
    } else {
      return getImageUrl(photos[0]['photo_reference']);
    }
  }

  static String getImageUrl(String photo) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=600"
        "&photoreference=$photo&key=$mapsAPIKey";
  }

  static String getPriceLevel(dynamic priceLevel) {
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

  static List<String> getOpeningHours(dynamic opening) {
    return opening == null ? [] : List<String>.from(opening['weekday_text'] ?? []);
  }

  static String getSanitisedImageAuthor(String author) {
    return EscapeHtmlUtils.removeEscapedHtml(EscapeHtmlUtils.removeHtmlTags(author));
  }

  static String getNearbySearchURL(
    LatLng coordinates,
    GMapsPlaceType type, {
    int radius = 5000,
  }) {
    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${coordinates.latitude},${coordinates.longitude}'
        '&radius=$radius&type=${type.toString()}&language=bg&key=$mapsAPIKey';

    return url;
  }

  static String getPlaceDetailsURL(String id) {
    final url = "https://maps.googleapis.com/maps/api/place/details/json?"
        "place_id=$id&fields=name,formatted_address,international_phone_number,"
        "geometry/location,opening_hours/weekday_text,photos,price_level,rating,reviews,"
        "url,user_ratings_total,website,price_level&language=bg&key=$mapsAPIKey";

    return url;
  }

  static String getMapTileWithPinURL(
    LatLng coordinates, {
    int zoom = 14,
    String lang = 'bg',
    String size = '600x200',
  }) {
    final lat = coordinates.latitude;
    final lng = coordinates.longitude;
    final url = "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng"
        "&zoom=$zoom&size=$size&scale=2&markers=color:red|$lat,$lng"
        "&language=$lang&key=$mapsAPIKey";

    return url;
  }
}
