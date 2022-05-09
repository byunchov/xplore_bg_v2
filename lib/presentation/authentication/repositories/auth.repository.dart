import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/models/models.dart';

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<UserModel?> signInWithGoogle();
  Future<UserModel?> signInWithFacebook();
  UserModel? getCurrentUser();
  Future<void> signOut();
}

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository implements BaseAuthRepository {
  final Reader _read;

  const AuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges => _read(firebaseAuthProvider).authStateChanges();

  Future<void> signInAnonymously() async {
    try {
      await _read(firebaseAuthProvider).signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message!);
    }
  }

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final result = await _read(firebaseAuthProvider).signInWithCredential(credential);
      final user = result.user;
      return user != null ? UserModel.fromFirebaseUser(user) : null;
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message!);
    }
  }

  @override
  Future<UserModel?> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final credential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      final result = await _read(firebaseAuthProvider).signInWithCredential(credential);
      final user = result.user;
      return user != null ? UserModel.fromFirebaseUser(user) : null;
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message!);
    }
  }

  @override
  UserModel? getCurrentUser() {
    try {
      final user = _read(firebaseAuthProvider).currentUser;
      return user != null ? UserModel.fromFirebaseUser(user) : null;
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message!);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _read(firebaseAuthProvider).signOut();
      // await signInAnonymously();
    } on FirebaseAuthException catch (e) {
      throw Failure(message: e.message!);
    }
  }
}
