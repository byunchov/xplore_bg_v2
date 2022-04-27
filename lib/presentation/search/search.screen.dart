import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/presentation/search/widgets/history.widget.dart';
import 'package:xplore_bg_v2/presentation/search/widgets/results.widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/search.controller.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    // Get.put(SearchController());
    _searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    // ref.read(searchHistoryProvider.notifier).dispose();
    super.dispose();
    print("_SearchScreenState disposed");
  }

  @override
  Widget build(BuildContext context) {
    // final results = ref.watch(locationSearchProvider);
    final theme = Theme.of(context);

    final query = ref.watch(searchFieldProvider);
    final controller = ref.watch(searchFieldProvider.notifier);

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppbarTitleWidget(
            title: _searchBar(theme),
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
                  _searchController.clear();
                  controller.state = "";
                  _searchFocusNode.requestFocus();
                },
              ),
            ],
          ),
        ),
        body: Visibility(
          visible: query.isEmpty,
          child: const SearchHistoryWidget(),
          replacement: const SearchResultsWidget(),
        ),
      ),
    );
  }

  Widget _searchBar(ThemeData theme) {
    // final _searchController = controller.searchFieldController;
    return Expanded(
      child: Center(
        child: TextFormField(
          autofocus: true,
          controller: _searchController,
          focusNode: _searchFocusNode,
          // style: TextStyle(fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: LocaleKeys.search_places.tr(),
            hintStyle: const TextStyle(fontWeight: FontWeight.w500),
            focusColor: theme.primaryColor,
            // prefixIcon: IconButton(
            //   icon: const Icon(Icons.close),
            //   onPressed: () => Get.back(),
            // ),
            // suffixIcon: IconButton(
            //   icon: const Icon(Icons.backspace_outlined),
            //   onPressed: () => _searchController.clear(),
            // ),
          ),
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) async {
            ref.read(searchHistoryProvider.notifier).addSearchTerm(value);
            ref.read(searchFieldProvider.notifier).state = value;
            // if (value.isNotEmpty) {
            //   await controller.getSearchResults(value);
            // }
          },
        ),
      ),
    );
  }
}
