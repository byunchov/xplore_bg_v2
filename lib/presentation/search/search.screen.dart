import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xplore_bg_v2/presentation/search/widgets/history.widget.dart';
import 'package:xplore_bg_v2/presentation/search/widgets/results.widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/search.controller.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final results = ref.watch(locationSearchProvider);
    final theme = Theme.of(context);

    final history = ref.watch(searchHistoryProvider);
    final result = ref.watch(paginatedPlaceSearchProvider);

    final query = ref.watch(searchFieldProvider);
    final controller = ref.watch(searchFieldProvider.notifier);
    final searchController = ref.read(searchTextControllerProvider);

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppbarTitleWidget(
            title: const _SearchBarHeaderWidget(),
            leadingSpaceAfter: 16,
            leading: AppbarActionWidget(
              iconData: Icons.adaptive.arrow_back,
              buttonSize: 42,
              onTap: () {
                context.router.pop();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.backspace_outlined),
                color: theme.iconTheme.color,
                onPressed: () {
                  searchController.clear();
                  controller.state = "";
                },
              ),
            ],
          ),
        ),
        body: query.isEmpty ? const SearchHistoryWidget() : const SearchResultsWidget(),
      ),
    );
  }
}

class _SearchBarHeaderWidget extends ConsumerWidget {
  const _SearchBarHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchTextControllerProvider);
    final theme = Theme.of(context);
    return Expanded(
      child: Center(
        child: TextFormField(
          autofocus: true,
          controller: searchController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: LocaleKeys.search_places.tr(),
            hintStyle: const TextStyle(fontWeight: FontWeight.w500),
            focusColor: theme.primaryColor,
          ),
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) async {
            ref.read(searchHistoryProvider.notifier).addSearchTerm(value);
            ref.read(searchFieldProvider.notifier).state = value;
          },
        ),
      ),
    );
  }
}
