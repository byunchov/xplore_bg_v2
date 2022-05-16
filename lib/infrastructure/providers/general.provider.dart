import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/app_locale.notifier.dart';
import 'package:xplore_bg_v2/infrastructure/routing/auth.guard.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final dioProvider = Provider<Dio>((ref) {
  return Dio();
});

final appLocaleProvider = StateNotifierProvider<AppLocaleState, Locale>((ref) {
  return AppLocaleState();
});

// final appLocaleProvider = StateProvider<Locale>((ref) {
//   // final box = GetStorage();
//   // final lang = box.read(StorageConstants.appLocale);
//   return const Locale('bg');
// });

final appRouterProvider = Provider<AppRouter>((ref) {
  return AppRouter(authGuard: AuthGuard(ref));
});
