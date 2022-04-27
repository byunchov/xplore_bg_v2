import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meilisearch/meilisearch.dart';
import 'package:xplore_bg_v2/domain/core/constants/storage.constants.dart';
import 'package:xplore_bg_v2/models/place.model.dart';

final searchClientProvider = Provider<MeiliSearchClient>((ref) {
  return MeiliSearchClient(
    'https://xplorebg.ddns.net',
    'ZBRX7Scz798580600a1f2a1ce48b6ccc597810e656467a9000ba6c16461e6cb1909a9f3f',
    2500,
  );
});

final searchFieldProvider = StateProvider.autoDispose<String>((ref) => "");

final locationSearchProvider = FutureProvider.autoDispose<List<PlaceModel>>((ref) async {
  final query = ref.watch(searchFieldProvider);
  if (query.isNotEmpty) {
    final index = await ref.read(searchClientProvider).getIndex('locations');
    final searchResult = await index.search(query, limit: 10, filter: ['lang = "bg"']);
    return searchResult.hits!.map((e) => PlaceModel.previewFromJson(e)).toList();
  }
  return [];
});

class SearchResultNotifier extends StateNotifier<List<PlacePreview>> {
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
    _reader(searchFieldProvider.notifier).state = query;
  }
}
