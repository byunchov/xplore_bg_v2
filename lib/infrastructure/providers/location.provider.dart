import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';

final locationProvider =
    StateNotifierProvider.autoDispose<UserLocationNotifier, AsyncValue<Position>>(
  (ref) => UserLocationNotifier(const AsyncValue.loading())..getContinuousLocation(),
);

class UserLocationNotifier extends StateNotifier<AsyncValue<Position>> {
  UserLocationNotifier(AsyncValue<Position> state) : super(state);

  Future<void> getContinuousLocation() async {
    try {
      if (await checkPermission()) {
        final position = await Geolocator.getCurrentPosition();
        state = AsyncValue.data(position);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
    }
  }

  Future<bool> checkPermission() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    try {
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        state = const AsyncValue.error(Failure(message: "ServiceError"));
      }
      _permission = await Geolocator.checkPermission();
      if (_permission == LocationPermission.denied) {
        _permission = await Geolocator.requestPermission();
        if (_permission == LocationPermission.denied) {
          state = const AsyncValue.error(Failure(message: "DeniedPermissionError"));
        }
      } else if (_permission == LocationPermission.whileInUse) {
        return true;
      } else if (_permission == LocationPermission.deniedForever) {
        state = const AsyncValue.error(Failure(message: "DeniedForeverError"));
      }
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, stackTrace: st);
      rethrow;
    }
  }
}
