import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/utils/escape_html.util.dart';

enum GMapsPlaceType {
  restaurant,
  lodging,
}

class GMapsUtils {
  static String get mapsAPIKey => dotenv.env['MAPS_API_KEY']!;

  static Map<String, String> fallbackThumbnails = {
    "restaurant":
        "https://firebasestorage.googleapis.com/v0/b/xplore-bg-v2.appspot.com/o/images%2Fmisc%2Frestaurant.jpg?alt=media&token=aa1a6af4-bd66-491a-b870-3096cdcd623e",
    "lodging":
        "https://firebasestorage.googleapis.com/v0/b/xplore-bg-v2.appspot.com/o/images%2Fmisc%2Fhotel.jpg?alt=media&token=a7adfe07-06a1-4bb7-94ec-9b5ba60ce128",
  };

  static String getThumbnail(List? photos, Map<String, dynamic> snapshot) {
    if (photos == null) {
      final types = List<String>.from(snapshot['types']);
      for (var type in GMapsPlaceType.values) {
        if (types.contains(type.name)) {
          return fallbackThumbnails[type.name]!;
        }
      }
      return fallbackThumbnails["restaurant"]!;
      // return snapshot['icon'] as String;
    } else {
      return getImageUrl(photos[0]['photo_reference']);
    }
  }

  static String getImageUrl(String photo, {int maxWidth = 800}) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=$maxWidth"
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

  static String getNearbySearchURL(LatLng coordinates, GMapsPlaceType type,
      {int? radius, int? maxResults = 20, String lang = 'bg'}) {
    final radiusQuery = radius != null ? '&radius=$radius' : '';
    final limit = maxResults != null ? "&maxResults=$maxResults" : "";
    final rankBy = radius == null ? "&rankby=distance" : "";

    final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
        '?location=${coordinates.latitude},${coordinates.longitude}$radiusQuery'
        '&type=${type.name}$rankBy$limit&language=$lang&key=$mapsAPIKey';

    return url;
  }

  static String getPlaceDetailsURL(String id, {String lang = 'bg'}) {
    final url = "https://maps.googleapis.com/maps/api/place/details/json?"
        "place_id=$id&fields=name,formatted_address,international_phone_number,"
        "geometry/location,opening_hours/weekday_text,photos,price_level,rating,reviews,"
        "url,user_ratings_total,website,price_level,types&language=$lang&key=$mapsAPIKey";

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

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
