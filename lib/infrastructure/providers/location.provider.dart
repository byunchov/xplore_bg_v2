import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

final locationProvider = StateNotifierProvider<UserLocationNotifier, AsyncValue<Position>>(
  (ref) => UserLocationNotifier(const AsyncValue.loading())..getContinuousLocation(),
);

class UserLocationNotifier extends StateNotifier<AsyncValue<Position>> {
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  StreamSubscription<Position>? positionStream;
  StreamSubscription<ServiceStatus>? serviceStatusStream;

  UserLocationNotifier(AsyncValue<Position> state) : super(state);

  @override
  void dispose() {
    positionStream?.cancel();
    serviceStatusStream?.cancel();
    super.dispose();
  }

  void init() {
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (position) {
        log(position.toString(), name: "${runtimeType.toString()} -> positionStream");
        state = AsyncValue.data(position);

        // try {
        //   log(position.toString(), name: "${runtimeType.toString()} -> positionStream");
        //   state = AsyncValue.data(position);
        // } catch (e) {
        //   log(e.toString(), name: "${runtimeType.toString()} -> positionStream");
        // }
      },
      onError: (err) {
        log(err.toString(), name: "${runtimeType.toString()} -> positionStream");
      },
    );

    serviceStatusStream = Geolocator.getServiceStatusStream().listen(
      (status) async {
        switch (status) {
          case ServiceStatus.disabled:
            state = const AsyncValue.error(
                Failure(message: LocaleKeys.error_loaction_service_disabled));
            break;
          case ServiceStatus.enabled:
            final position = await Geolocator.getCurrentPosition();
            state = AsyncValue.data(position);
            break;
        }
        log(status.toString(), name: "${runtimeType.toString()} -> onData");
      },
      onError: (error) {
        if (error is LocationServiceDisabledException) {
          state =
              const AsyncValue.error(Failure(message: LocaleKeys.error_loaction_service_disabled));
        }
        log(error.toString(), name: runtimeType.toString());
      },
    );
  }

  Future<void> getContinuousLocation() async {
    try {
      if (await checkPermission()) {
        final position = await Geolocator.getCurrentPosition();
        state = AsyncValue.data(position);
      }
    } on LocationServiceDisabledException {
      state = const AsyncValue.error(Failure(message: LocaleKeys.error_loaction_service_disabled));
    } catch (e, st) {
      state = AsyncValue.error(Failure(message: e.toString()), stackTrace: st);
    }
  }

  Future<bool> checkPermission() async {
    bool _serviceEnabled;
    LocationPermission _permission;

    try {
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        state =
            const AsyncValue.error(Failure(message: LocaleKeys.error_loaction_service_disabled));
      }
      _permission = await Geolocator.checkPermission();
      if (_permission == LocationPermission.denied) {
        _permission = await Geolocator.requestPermission();
        if (_permission == LocationPermission.denied) {
          state =
              const AsyncValue.error(Failure(message: LocaleKeys.error_loaction_denied_permission));
        }
      } else if (_permission == LocationPermission.whileInUse) {
        return true;
      } else if (_permission == LocationPermission.deniedForever) {
        state = const AsyncValue.error(Failure(message: LocaleKeys.error_loaction_denied_forever));
      }
      return true;
    } on LocationServiceDisabledException {
      state = const AsyncValue.error(Failure(message: LocaleKeys.error_loaction_service_disabled));
      return false;
    } catch (e) {
      state = AsyncValue.error(Failure(message: e.toString()));
      return false;
    }
  }
}
