import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/bookmarks.controller.dart';

class LikedLocationsScreen extends ConsumerWidget {
  const LikedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(likedLocationsProvider);

    return RefreshIndicator(
      onRefresh: () => ref.refresh(likedLocationsProvider.future),
      child: liked.when(
        data: (data) => ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          itemCount: data.length,
          itemBuilder: (ctx, index) {
            return PlaceListTile(placePreview: data[index]);
          },
          separatorBuilder: (ctx, index) => const SizedBox(height: 2),
        ),
        error: (err, _) => Column(
          children: [
            Text(err.toString()),
            IconButton(
              onPressed: () async => ref.refresh(likedLocationsProvider.future),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        loading: () => ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemCount: 5,
          itemBuilder: (contex, index) {
            return const PLaceTileLoadingWidget();
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 15);
          },
        ),
      ),
    );
  }
}
