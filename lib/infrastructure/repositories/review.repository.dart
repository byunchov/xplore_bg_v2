import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/add_review.provider.dart';

class ReviewRepository {
  final Reader _read;

  ReviewRepository(this._read);

  Future<void> saveUserReview(String locId) async {
    final user = _read(authControllerProvider);
    final rating = _read(reviewRatingValueProvider(locId));
    final content = _read(reviewTextControllerProvider(locId)).text;
    final firestore = _read(firebaseFirestoreProvider);

    final reviewId = "$locId@${user!.uid}";
    final hashId = md5.convert(utf8.encode(reviewId)).toString();

    final review = ReviewModel(
      id: hashId,
      locId: locId,
      uid: user.uid,
      fullName: user.fullName,
      profileImage: user.profileImage,
      lang: "bg",
      rating: rating,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final reviewData = review.toMap();
    reviewData.removeWhere((k, v) => v == null);
    try {
      await firestore.collection("locations/$locId/reviews").doc(user.uid).set(reviewData);
    } on FirebaseException catch (e) {
      throw Failure(message: e.message!);
    }
  }

  Future<void> deleteUserReview(String locId) async {
    final user = _read(authControllerProvider);
    final firestore = _read(firebaseFirestoreProvider);
    // final review = firestore.collection("locations/$locId/reviews").doc(user!.uid);

    try {
      await firestore.doc("locations/$locId/reviews/${user!.uid}").delete();
    } on FirebaseException catch (e) {
      throw Failure(message: e.message!);
    }
    // await firestore.doc("locations/$locId/reviews/${user!.uid}").delete();
  }
}
