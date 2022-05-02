/* import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:http/http.dart' as http;

final restaurantsListProvider =
    FutureProvider.autoDispose.family<List<RestaurantModel>, LatLng>((ref, coordinates) async {
  const mapAPIKey = AppConfig.mapsAPIKey;
  final dataUrl = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
      '?location=${coordinates.latitude},${coordinates.longitude}'
      '&radius=5000&type=restaurant&language=bg&key=$mapAPIKey';

  List<RestaurantModel> vicinityList;

  http.Response response = await http.get(Uri.parse(dataUrl));

  if (response.statusCode == 200) {
    var snapshot = jsonDecode(response.body);
    if (snapshot['results']?.isEmpty) {
      return [];
    } else {
      final data = List.from(snapshot['results']);
      vicinityList = data.map((e) => RestaurantModel.previewFromJson(e)).toList();

      vicinityList.sort(((a, b) => b.rating.compareTo(a.rating)));
      return vicinityList;
    }
  }
  return [];
});

final restaurantDetailsProvider =
    FutureProvider.autoDispose.family<RestaurantModel?, String>((ref, id) async {
  const mapAPIKey = AppConfig.mapsAPIKey;
  final url = "https://maps.googleapis.com/maps/api/place/details/json?"
      "place_id=$id&fields=name,formatted_address,international_phone_number,"
      "geometry/location,opening_hours/weekday_text,photos,price_level,rating,reviews,"
      "url,user_ratings_total,website,price_level&language=bg&key=$mapAPIKey";

  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // print(response.body);
    var snapshot = jsonDecode(response.body);
    if (snapshot['result'] == null) {
      return null;
    } else {
      return RestaurantModel.formJson(snapshot['result'], id)..subcategory = "Restaurant";
    }
  }
});
 */