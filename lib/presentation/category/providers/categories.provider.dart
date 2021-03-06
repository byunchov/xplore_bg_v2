// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/category/models/filter_checkbox.model.dart';

final categoryPaginatedListProvider = StateNotifierProvider.autoDispose
    .family<PaginationNotifier<PlaceModel>, PaginationState<PlaceModel>, String>((ref, tag) {
  ref.watch(categoryFacetsProvider(tag).select((value) => null));

  final subcategoryFilters = ref.watch(subcategoryFilterListProvider(tag));
  final sortBy = ref.watch(categorySortCriteriaProvider(tag));
  final sortOrder = ref.watch(categorySortOrderDirectionProvider(tag));
  final lang = ref.watch(appLocaleProvider).languageCode;

  return PaginationNotifier<PlaceModel>(
      itemsPerBatch: 10,
      fetchNextItems: (item, {limit}) async {
        final repository = ref.watch(searcRepositoryProvider);

        final cancelToken = CancelToken();
        ref.onDispose(cancelToken.cancel);

        await Future<void>.delayed(const Duration(milliseconds: 250));
        if (cancelToken.isCancelled) throw AbortedException();

        log("searching for $tag", name: "categoryPaginatedListProvider");

        final result = await repository.search(
          'locations',
          query: "",
          limit: limit,
          offset: item?.offset,
          filter: ["lang=$lang", "category_tag=$tag", subcategoryFilters],
          sort: ["${sortBy.name}:${sortOrder.name}"],
          attributesToRetrieve: repository.previewAttributes,
          cancelToken: cancelToken,
        );
        final data = result.hits?.map((e) => PlaceModel.previewFromJson(e)).toList();

        return data ?? [];
      })
    ..init();
});

final categoryLocationListProvider =
    FutureProvider.autoDispose.family<List<PlaceModel>, String>((ref, tag) async {
  final repository = ref.read(searcRepositoryProvider);
  final lang = ref.watch(appLocaleProvider).languageCode;

  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  await Future<void>.delayed(const Duration(milliseconds: 250));
  if (cancelToken.isCancelled) throw AbortedException();

  final result = await repository.search(
    'locations',
    query: "",
    limit: 10,
    filter: ["lang=$lang", "category_tag=$tag"],
    attributesToRetrieve: repository.previewAttributes,
    cancelToken: cancelToken,
  );
  final data = result.hits?.map((e) => PlaceModel.previewFromJson(e)).toList();

  return data!;
});

final categoryFacetsProvider =
    FutureProvider.autoDispose.family<List<SubcategoryCheckBox>, String>((ref, tag) async {
  const field = "subcategory";
  final repository = ref.read(searcRepositoryProvider);
  final lang = ref.watch(appLocaleProvider).languageCode;

  final cancelToken = CancelToken();
  ref.onDispose(cancelToken.cancel);

  await Future<void>.delayed(const Duration(milliseconds: 250));
  if (cancelToken.isCancelled) throw AbortedException();

  final response = await repository.search(
    'locations',
    query: "",
    filter: ["lang=$lang", "category_tag=$tag"],
    facetsDistribution: [field],
    cancelToken: cancelToken,
  );
  final facets = Map<String, int>.from(response.facetsDistribution[field]);
  final result = facets.entries.map((e) => SubcategoryCheckBox(name: e.key, itemCount: e.value));

  return result.toList();
});

final categorySortOrderDirectionProvider =
    StateProvider.autoDispose.family<CategorySortOrder, String>((ref, tag) {
  return CategorySortOrder.asc;
});

final categorySortCriteriaProvider =
    StateProvider.autoDispose.family<CategorySortableCriteria, String>((ref, tag) {
  return CategorySortableCriteria.rating;
});

final subcategoryFilterListProvider =
    StateProvider.autoDispose.family<List<String>, String>((ref, tag) {
  return [];
});

class AbortedException implements Exception {}
