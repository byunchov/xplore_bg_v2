import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';

final likedPlacesProvider =
    StateNotifierProvider.autoDispose<PaginationNotifier<PlaceModel>, PaginationState<PlaceModel>>(
        (ref) {
  return PaginationNotifier(
    itemsPerBatch: 10,
    fetchNextItems: (item, {limit}) async {
      final user = ref.watch(authControllerProvider);
      // return [];

      if (user == null) return [];

      final itemsPerBatch = limit ?? 20;

      final firestore = ref.read(firebaseFirestoreProvider);
      final searchRepo = ref.read(searcRepositoryProvider);

      final itemsCollectionRef = firestore.collection('users').doc(user.uid).collection('likes');

      Future<List<PlaceModel>> mapSnapshot(QuerySnapshot querySnapshot) async {
        List<PlaceModel> locations = [];
        for (var doc in querySnapshot.docs) {
          final snap = await searchRepo.getDocument("locations", "bg_${doc.id}");
          if (snap != null) {
            locations.add(PlaceModel.previewFromJson(snap));
          }
        }
        return locations;
      }

      if (item == null) {
        final snapshot =
            await itemsCollectionRef.orderBy("id", descending: true).limit(itemsPerBatch).get();

        return await mapSnapshot(snapshot);
      } else {
        final snapshot = await itemsCollectionRef
            .orderBy("id", descending: true)
            .startAfter([item.item.id])
            .limit(itemsPerBatch)
            .get();

        return await mapSnapshot(snapshot);
      }
    },
  )..init();
});

// TODO DRY this providers
final bookmarkedPlacesProvider =
    StateNotifierProvider.autoDispose<PaginationNotifier<PlaceModel>, PaginationState<PlaceModel>>(
        (ref) {
  return PaginationNotifier(
    itemsPerBatch: 10,
    fetchNextItems: (item, {limit}) async {
      final user = ref.watch(authControllerProvider);
      // return [];

      if (user == null) return [];

      final itemsPerBatch = limit ?? 20;

      final firestore = ref.read(firebaseFirestoreProvider);
      final searchRepo = ref.read(searcRepositoryProvider);

      final itemsCollectionRef =
          firestore.collection('users').doc(user.uid).collection('bookmarks');

      Future<List<PlaceModel>> mapSnapshot(QuerySnapshot querySnapshot) async {
        List<PlaceModel> locations = [];
        for (var doc in querySnapshot.docs) {
          // TODO add app locale provider
          final snap = await searchRepo.getDocument("locations", "bg_${doc.id}");
          if (snap != null) {
            locations.add(PlaceModel.previewFromJson(snap));
          }
        }
        return locations;
      }

      if (item == null) {
        final snapshot =
            await itemsCollectionRef.orderBy("id", descending: true).limit(itemsPerBatch).get();

        return await mapSnapshot(snapshot);
      } else {
        final snapshot = await itemsCollectionRef
            .orderBy("id", descending: true)
            .startAfter([item.item.id])
            .limit(itemsPerBatch)
            .get();

        return await mapSnapshot(snapshot);
      }
    },
  )..init();
});
