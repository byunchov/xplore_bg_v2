import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
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
        child: const Icon(Icons.filter_alt),
        onPressed: () {
          context.router.push(CategoryFilterRoute(tag: tag, name: category!.name));
        },
      ),
    );
  }

  Widget _categoryList() {
    final provider = categoryPaginatedListProvider(tag);
    return PaginatedListViewWidget<PlaceModel>(
      provider: provider,
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
}
