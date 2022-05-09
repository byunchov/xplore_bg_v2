import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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

  StreamSubscription<User?>? _authStateChangesSubscription;

  AuthController(this._read) : super(null) {
    _authStateChangesSubscription?.cancel();
    _authStateChangesSubscription = _read(authRepositoryProvider).authStateChanges.listen((user) {
      state = (user != null) ? UserModel.fromFirebaseUser(user) : null;
    });
  }

  bool get isAuthenticated => state != null;

  @override
  void dispose() {
    _authStateChangesSubscription?.cancel();
    super.dispose();
  }

  void appStarted() async {
    final user = _read(authRepositoryProvider).getCurrentUser();
    // if (user == null) {
    //   await _read(authRepositoryProvider).signInAnonymously();
    // }
  }

  void signOut() async {
    await _read(authRepositoryProvider).signOut();
  }
}
