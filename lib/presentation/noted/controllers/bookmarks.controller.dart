import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';

final notedPlacesProvider = StateNotifierProvider.family<PaginationNotifier<PlaceModel>,
    PaginationState<PlaceModel>, String>((ref, field) {
  return PaginationNotifier(
    itemsPerBatch: 10,
    fetchNextItems: (item, {limit}) async {
      final user = ref.watch(authControllerProvider);
      // return [];

      if (user == null) return [];

      final itemsPerBatch = limit ?? 20;

      final firestore = ref.read(firebaseFirestoreProvider);
      final searchRepo = ref.read(searcRepositoryProvider);
      final lang = ref.watch(appLocaleProvider).languageCode;

      final itemsCollectionRef = firestore.collection('users').doc(user.uid).collection(field);

      if (item == null) {
        final snapshot =
            await itemsCollectionRef.orderBy("id", descending: true).limit(itemsPerBatch).get();

        return await _mapSnapshot(snapshot, searchRepo, lang);
      } else {
        final snapshot = await itemsCollectionRef
            .orderBy("id", descending: true)
            .startAfter([item.item.id])
            .limit(itemsPerBatch)
            .get();

        return await _mapSnapshot(snapshot, searchRepo, lang);
      }
    },
  )..init();
});

Future<List<PlaceModel>> _mapSnapshot(
  QuerySnapshot querySnapshot,
  SearchRepository repo,
  String locale, {
  String field = 'locations',
}) async {
  List<PlaceModel> locations = [];
  for (var doc in querySnapshot.docs) {
    final snap = await repo.getDocument(field, "${locale}_${doc.id}");
    if (snap != null) {
      locations.add(PlaceModel.previewFromJson(snap));
    }
  }
  return locations;
}
