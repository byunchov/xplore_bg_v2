import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/constants/storage.constants.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
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
      isAuthenticated = user != null;

      _getFirebaseUser(user);
      // state = (user != null) ? UserModel.fromFirebaseUser(user) : null;
    });
  }

  bool isGuest = false;
  bool isAuthenticated = false;

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
    log("Guest login", name: runtimeType.toString());
  }

  void signOutGuest() async {
    isGuest = false;
    await _box.write(StorageConstants.gusetLogin, isGuest);
    log("Guest logout", name: runtimeType.toString());
  }

  void signOut() async {
    signOutGuest();
    await _read(authRepositoryProvider).signOut();
  }

  Future<bool> deleteUserAccount() async {
    final uid = state?.uid;
    if (uid == null) return false;
    final firestore = _read(firebaseFirestoreProvider);

    try {
      await firestore.doc("users/$uid").delete();
      signOut();
      return true;
    } on FirebaseException catch (e) {
      throw Failure(message: e.message!);
    }
  }

  @protected
  Future<void> _getFirebaseUser(User? user) async {
    if (user != null) {
      final uid = user.uid;
      final tempUser = await _read(firebaseFirestoreProvider).doc("users/$uid").get();
      final data = tempUser.data();
      if (data == null) return;

      state = UserModel.fromMap(data);
      // isAuthenticated = true;
      return;
    }

    state = null;
    // isAuthenticated = false;
  }
}
