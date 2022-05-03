import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meilisearch/meilisearch.dart';
import 'package:xplore_bg_v2/domain/core/constants/storage.constants.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';

final searchClientProvider = Provider<MeiliSearchClient>((ref) {
  return MeiliSearchClient(
    'https://xplorebg.ddns.net',
    'ZBRX7Scz798580600a1f2a1ce48b6ccc597810e656467a9000ba6c16461e6cb1909a9f3f',
    2500,
  );
});

final searchFieldProvider = StateProvider.autoDispose<String>((ref) => "");

final paginatedPlaceSearchProvider =
    StateNotifierProvider.autoDispose<PaginationNotifier<PlaceModel>, PaginationState<PlaceModel>>(
        (ref) {
  final query = ref.watch(searchFieldProvider);

  return PaginationNotifier<PlaceModel>(
      itemsPerBatch: 10,
      fetchNextItems: (item, {limit}) async {
        final repository = ref.watch(searcRepositoryProvider);

        final cancelToken = CancelToken();
        ref.onDispose(cancelToken.cancel);

        await Future<void>.delayed(const Duration(milliseconds: 250));
        if (cancelToken.isCancelled) throw AbortedException();

        log("searching for $query", name: "categoryPaginatedListProvider");

        final result = await repository.search(
          'locations',
          query: query,
          limit: limit,
          offset: item?.offset,
          attributesToRetrieve: repository.previewAttributes,
        );
        final data = result.hits?.map((e) => PlaceModel.previewFromJson(e)).toList();

        return data ?? [];
      })
    ..init();
});

class AbortedException implements Exception {}

final searchTextControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  ref.onDispose(() => ref.state.dispose());
  return TextEditingController();
});

class SearchResultNotifier extends StateNotifier<List<PlaceModel>> {
  SearchResultNotifier() : super([]);
}

final searchHistoryProvider =
    StateNotifierProvider.autoDispose<SearchHistoryNotifier, List<String>>((ref) {
  ref.onDispose(() => ref.notifier.saveSearchHistory());
  return SearchHistoryNotifier(ref.read);
});

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  final _box = GetStorage();
  final List<String> _searchHistory = [];

  final Reader _reader;

  SearchHistoryNotifier(this._reader) : super([]) {
    getSearchHistory();
  }

  void getSearchHistory() {
    final dump = _box.read(StorageConstants.searchHistory) ?? "[]";
    final history = List<String>.from(jsonDecode(dump));
    state = [...history];
    _searchHistory.clear();
    _searchHistory.addAll(state);
    // return _searchHistory;
    print(dump);
  }

  void saveSearchHistory() {
    final savedHistory = _box.read(StorageConstants.searchHistory) ?? "[]";
    final dump = jsonEncode(state);

    if (savedHistory != dump) {
      _box.write(StorageConstants.searchHistory, dump);
      print(dump);
    } else {
      print("Nothing changed");
    }
  }

  List<String> filterSearchTerms({String? filter}) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed.where((term) => term.startsWith(filter)).toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > StorageConstants.historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - StorageConstants.historyLength);
    }
    state = filterSearchTerms();
  }

  void deleteSearchTerm(String term) {
    // _searchHistory.removeWhere((t) => t == term);
    _searchHistory.remove(term);
    state = filterSearchTerms();
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  void setSearchTermFromHistory(String query) {
    addSearchTerm(query);
    _reader(searchTextControllerProvider).text = query;
    _reader(searchFieldProvider.notifier).state = query;
  }
}
