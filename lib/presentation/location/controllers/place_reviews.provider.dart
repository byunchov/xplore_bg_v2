import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';

class AbortedException implements Exception {}

final placeReiewListProvider = StateNotifierProvider.autoDispose
    .family<PaginationNotifier<ReviewModel>, PaginationState<ReviewModel>, String>((ref, id) {
  return PaginationNotifier<ReviewModel>(
      itemsPerBatch: 10,
      fetchNextItems: (item, {limit}) async {
        final repository = ref.watch(searcRepositoryProvider);

        final cancelToken = CancelToken();
        ref.onDispose(cancelToken.cancel);

        await Future<void>.delayed(const Duration(milliseconds: 250));
        if (cancelToken.isCancelled) throw AbortedException();

        log("Loading reviews for $id", name: "placeReiewListProvider");

        final result = await repository.search(
          'reviews',
          query: "",
          limit: limit,
          offset: item?.offset,
          filter: ["loc_id=$id"],
        );
        final data = result.hits?.map<ReviewModel>(ReviewModel.fromMap).toList();

        return data ?? [];
      })
    ..init();
});

final placeUserReviewProvider =
    FutureProvider.autoDispose.family<ReviewModel?, String>((ref, id) async {
  final user = ref.read(authControllerProvider);
  final repository = ref.watch(searcRepositoryProvider);

  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  await Future<void>.delayed(const Duration(milliseconds: 250));
  if (cancelToken.isCancelled) return null;

  log("Loading reviews for $id", name: "placeReiewListProvider");

  final result = await repository.search(
    'reviews',
    query: "",
    limit: 1,
    filter: ["loc_id=$id", "uid=${user!.uid}"],
  );
  final data = result.hits?.map<ReviewModel>(ReviewModel.fromMap).toList();

  return data!.isEmpty ? null : data.first;
});
