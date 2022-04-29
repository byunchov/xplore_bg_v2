import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';

final bookmarkLocationProvider = Provider<BookmarkRepository>((ref) {
  return BookmarkRepository(ref.read);
});

class BookmarkRepository {
  final Reader _read;

  const BookmarkRepository(this._read);

  Future<void> bookmarkLocation(String id) async {
    await _bookmarkLogic(id, 'bookmarks');
  }

  Future<void> likeLocation(String id) async {
    await _bookmarkLogic(id, 'likes');
  }

  Future<void> _bookmarkLogic(String id, String collection) async {
    final user = _read(authControllerProvider);
    final firestore = _read(firebaseFirestoreProvider);

    final collectionRef = firestore.doc('users/${user!.uid}').collection(collection);
    final query = await collectionRef.where('id', isEqualTo: id).get();
    final result = query.docs;

    if (result.isEmpty) {
      await collectionRef.doc(id).set({'id': id, 'created_at': 1245646});
    } else {
      await collectionRef.doc(id).delete();
    }
  }
}
