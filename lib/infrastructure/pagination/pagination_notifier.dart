import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xplore_bg_v2/models/pagination/pagination_state.model.dart';

class PaginationNotifier<T> extends StateNotifier<PaginationState<T>> {
  PaginationNotifier({
    required this.fetchNextItems,
    this.itemsPerBatch = 20,
  }) : super(const PaginationState.loading());

  final Future<List<T>> Function(T? item, {int? limit}) fetchNextItems;
  final int itemsPerBatch;

  final List<T> _items = [];

  Timer _timer = Timer(const Duration(milliseconds: 0), () {});

  bool noMoreItems = false;
  bool get hasData => _items.isNotEmpty;

  void init() {
    if (_items.isEmpty) {
      fetchFirstBatch();
    }
  }

  void updateData(List<T> result) {
    noMoreItems = result.length < itemsPerBatch;

    if (result.isEmpty) {
      state = PaginationState.data(_items);
    } else {
      state = PaginationState.data(_items..addAll(result));
    }
  }

  Future<void> fetchFirstBatch() async {
    try {
      state = const PaginationState.loading();

      final List<T> result = _items.isEmpty
          ? await fetchNextItems(null, limit: itemsPerBatch)
          : await fetchNextItems(_items.last, limit: itemsPerBatch);
      updateData(result);
    } catch (e, stk) {
      state = PaginationState.error(e, stk);
    }
  }

  Future<void> fetchNextBatch() async {
    if (_timer.isActive && _items.isNotEmpty) {
      return;
    }
    _timer = Timer(const Duration(milliseconds: 1000), () {});

    if (noMoreItems) {
      return;
    }

    if (state == PaginationState<T>.onGoingLoading(_items)) {
      log("Rejected");
      return;
    }

    log("Fetching next batch of items");

    state = PaginationState.onGoingLoading(_items);

    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await fetchNextItems(_items.last, limit: itemsPerBatch);
      log(result.length.toString());
      updateData(result);
    } catch (error, stackTrace) {
      log("Error fetching next page", error: error, stackTrace: stackTrace);
      state = PaginationState.onGoingError(_items, error, stackTrace);
    }
  }
}
