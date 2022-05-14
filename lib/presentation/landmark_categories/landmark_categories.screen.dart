import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/category.model.dart';
import 'package:xplore_bg_v2/presentation/landmark_categories/widgets/category_card.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final firestore = ref.read(firebaseFirestoreProvider);
  final test = await firestore.collection("categories").get();

  return test.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
});

class LandmarkCategoriesScreen extends ConsumerStatefulWidget {
  const LandmarkCategoriesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LandmarkCategoriesScreen> createState() => _LandmarkCategoriesScreenState();
}

class _LandmarkCategoriesScreenState extends ConsumerState<LandmarkCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);

    print(context.router.routeData.path);

    return Scaffold(
      appBar: AppBar(
        // elevation: 2.0,
        title: const Text(LocaleKeys.menu_landmarks).tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: categories.when(
          data: (data) => _quilted(data),
          error: (err, _) => Text(err.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _quilted(List<CategoryModel> categories) {
    return ScrollbarWrapperWidget(
      builder: (ctx, controller) => GridView.custom(
        controller: controller,
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          repeatPattern: QuiltedGridRepeatPattern.same,
          pattern: const [
            QuiltedGridTile(1, 2),
            QuiltedGridTile(2, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (ctx2, index) => CategoryCard(
            categoryItem: categories[index],
            onPressed: () {
              final categoryItem = categories[index];
              // context.router.navigate(CategoryRoute(id: categoryItem.tag!, category: categoryItem));

              // ctx2.pushRoute(HomeRoute(children: [
              //   LandmarkCategoriesRoute(
              //       children: [CategoryRoute(id: categoryItem.tag!, category: categoryItem)])
              // ]));
              context.router.push(CategoryRoute(category: categoryItem, tag: categoryItem.tag!));
            },
          ),
          childCount: categories.length,
        ),
      ),
    );
  }
}
