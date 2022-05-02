import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/typedef.util.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';

class MapsPlaceRepository {
  final Reader _read;

  MapsPlaceRepository(this._read);

  Future<JsonMap> getPlaceDetails(String id) async {
    final client = _read(dioProvider);
    try {
      final url = GMapsUtils.getPlaceDetailsURL(id);
      final response = await client.get(url);
      log(url, name: runtimeType.toString());
      log(response.data['results'].runtimeType.toString(), name: runtimeType.toString());

      return JsonMap.from(response.data['result']);
    } on TypeError {
      throw const Failure(message: "Empty result set");
    } on DioError catch (e) {
      throw Failure.fromDioError(e);
    }
  }

  Future<List<JsonMap>> getNearbyPlaces(LatLng coordinates, GMapsPlaceType type) async {
    final client = _read(dioProvider);
    try {
      final url = GMapsUtils.getNearbySearchURL(coordinates, type);
      final response = await client.get(url);
      log(url, name: runtimeType.toString());
      log(response.data['results'].runtimeType.toString(), name: runtimeType.toString());
      return List<JsonMap>.from(response.data['results']);
    } on TypeError {
      throw const Failure(message: "Empty result set");
    } on DioError catch (e) {
      throw Failure.fromDioError(e);
    }
  }
}
