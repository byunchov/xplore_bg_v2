import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/pagination/pagination_notifier.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/models/pagination/pagination_state.model.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';

final bookmarkedLocationsProvider = FutureProvider.autoDispose<List<PlaceModel>>((ref) async {
  final user = ref.read(authControllerProvider);
  final firestore = ref.read(firebaseFirestoreProvider);
  final documents =
      await firestore.collection('users').doc(user?.uid).collection('bookmarks').limit(10).get();

  // final searchIndex = await ref.read(searchClientProvider).getIndex('locations');
  final msProvider = ref.read(searcRepositoryProvider);

  List<PlaceModel> locations = [];

  for (var doc in documents.docs) {
    final snap = await msProvider.getDocument("locations", "bg_${doc.id}");
    if (snap != null) {
      locations.add(PlaceModel.previewFromJson(snap));
    }
  }

  return locations;
});

final likedLocationsProvider = FutureProvider.autoDispose<List<PlaceModel>>((ref) async {
  final user = ref.watch(authControllerProvider);

  if (user == null) return [];

  final firestore = ref.read(firebaseFirestoreProvider);
  final documents =
      await firestore.collection('users').doc(user.uid).collection('likes').limit(10).get();

  final msProvider = ref.read(searcRepositoryProvider);

  List<PlaceModel> locations = [];

  for (var doc in documents.docs) {
    final snap = await msProvider.getDocument("locations", "bg_${doc.id}");
    if (snap != null) {
      locations.add(PlaceModel.previewFromJson(snap));
    }
  }

  return locations;
});

final likedProvider =
    StateNotifierProvider.autoDispose<PaginationNotifier<PlaceModel>, PaginationState<PlaceModel>>(
        (ref) {
  return PaginationNotifier(
    itemsPerBatch: 5,
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
            .startAfter([item.id])
            .limit(itemsPerBatch)
            .get();

        return await mapSnapshot(snapshot);
      }
    },
  )..init();
});
