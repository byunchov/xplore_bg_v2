import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/location/repositories/maps_places.repository.dart';

final mapsPlaceRepositoryProvider = Provider<MapsPlaceRepository>((ref) {
  return MapsPlaceRepository(ref.read);
});
