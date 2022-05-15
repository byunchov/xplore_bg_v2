import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/constants/storage.constants.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/repositories/auth.repository.dart';

final authControllerProvider = StateNotifierProvider<AuthController, UserModel?>(
  (ref) => AuthController(ref.read)..appStarted(),
);

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChanges;
});

class AuthController extends StateNotifier<UserModel?> {
  final Reader _read;
  late GetStorage _box;

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) : super(null) {
    _box = GetStorage();
    isGuest = _box.read<bool>(StorageConstants.gusetLogin) ?? false;
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider).authStateChanges.listen((user) {
      final userModel = (user != null) ? UserModel.fromFirebaseUser(user) : null;
      state = userModel;
    });
  }

  bool isGuest = false;
  bool get isAuthenticated => state != null;

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    _read(authRepositoryProvider).getCurrentUser();
    // if (user == null) {
    //   await _read(authRepositoryProvider).signInAnonymously();
    // }
  }

  void siginGuest() {
    isGuest = true;
    _box.write(StorageConstants.gusetLogin, isGuest);
  }

  void signOut() async {
    await _read(authRepositoryProvider).signOut();
    isGuest = false;
    await _box.write(StorageConstants.gusetLogin, isGuest);
  }
}
