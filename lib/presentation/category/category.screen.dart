import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/pagination/paginated_list_view.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'providers/categories.provider.dart';

class CategoryScreen extends ConsumerWidget {
  final String tag;
  final CategoryModel? category;
  const CategoryScreen({
    Key? key,
    @pathParam required this.tag,
    this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(context.topRoute.path);

    // ref.watch(categoryFacetsProvider(tag).select((value) => null));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitleWidget(
          title: category!.name,
          leading: AppbarActionWidget(
            iconData: Icons.arrow_back,
            buttonSize: 42,
            onTap: () {
              context.router.pop();
            },
          ),
        ),
      ),
      body: _categoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(CategoryFilterRoute(tag: tag, name: category!.name));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _categoryList() {
    final provider = categoryPaginatedListProvider(tag);
    return PaginatedListViewWidget<PlaceModel>(
      provider: provider,
      loadingPlaceholder: const Center(child: CircularProgressIndicator()),
      emptyResultPlaceholder: BlankPage(
        heading: LocaleKeys.no_places_found.tr(),
        shortText: LocaleKeys.no_places_found_desc.tr(),
        icon: Icons.search_off_rounded,
      ),
      builder: (item) {
        return PlaceListTile(placePreview: item);
      },
    );
  }

  Widget _testList(WidgetRef ref) {
    final state = ref.watch(categoryPaginatedListProvider(tag));

    return state.when(
      data: (data) => _listView(data),
      loading: () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: 5,
        itemBuilder: (contex, index) {
          return const PlaceTileLoadingWidget();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 15);
        },
      ),
      error: (err, _) => Text(err.toString()),
      onGoingLoading: (data) => _listView(data),
      onGoingError: (data, e, stk) => Text("onGoingError: ${e.toString()}"),
    );
  }

  Widget _listView(List<PlaceModel> data) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        return PlaceListTile(placePreview: data[index]);
      },
      separatorBuilder: (ctx, index) => const SizedBox(width: 12),
    );
  }
}
