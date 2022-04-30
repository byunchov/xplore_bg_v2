import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';

final bookmarkLocationProvider = Provider<BookmarkRepository>((ref) {
  return BookmarkRepository(ref.read);
});

typedef NotedSuccessCallback = void Function(bool noted);
typedef NotedErrorCallback = void Function(dynamic error);

class BookmarkRepository {
  final Reader _read;

  const BookmarkRepository(this._read);

  Future<void> bookmarkLocation(
    String id, {
    NotedSuccessCallback? onSuccess,
    NotedErrorCallback? onError,
  }) async {
    await _bookmarkLogic(id, 'bookmarks', onSuccess: onSuccess, onError: onError);
  }

  Future<void> likeLocation(
    String id, {
    NotedSuccessCallback? onSuccess,
    NotedErrorCallback? onError,
  }) async {
    await _bookmarkLogic(id, 'likes', onSuccess: onSuccess, onError: onError);
  }

  Future<void> _bookmarkLogic(
    String id,
    String collection, {
    NotedSuccessCallback? onSuccess,
    NotedErrorCallback? onError,
  }) async {
    final user = _read(authControllerProvider);
    final firestore = _read(firebaseFirestoreProvider);

    final collectionRef = firestore.doc('users/${user!.uid}').collection(collection);
    final query = await collectionRef.where('id', isEqualTo: id).get();
    final result = query.docs;

    try {
      if (result.isEmpty) {
        final now = DateTime.now();
        await collectionRef.doc(id).set({'id': id, 'created_at': now.millisecondsSinceEpoch});
        onSuccess?.call(true);
      } else {
        await collectionRef.doc(id).delete();
        onSuccess?.call(false);
      }
    } catch (e) {
      onError?.call(e);
    }
  }
}
