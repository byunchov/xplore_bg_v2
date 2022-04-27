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
      body: _CategoryList(tag),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(CategoryFilterRoute(tag: tag, name: category!.name));
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _CategoryList extends ConsumerWidget {
  final String tag;
  const _CategoryList(this.tag, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locations = ref.watch(categoryLocationListProvider(tag));
    return locations.when(
      data: (data) => ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: data.length,
        itemBuilder: (ctx, index) {
          return PlaceListTile(placePreview: data[index]);
        },
        separatorBuilder: (ctx, index) => const SizedBox(width: 12),
      ),
      error: (err, _) => Text(err.toString()),
      loading: () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemCount: 5,
        itemBuilder: (contex, index) {
          return const PLaceTileLoadingWidget();
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 15);
        },
      ),
    );
  }
}

class SubcategoryCheckBox {
  final String name;
  final String? tag;
  final int itemCount;
  bool value;

  SubcategoryCheckBox({
    required this.name,
    required this.itemCount,
    this.tag,
    this.value = false,
  });
}
