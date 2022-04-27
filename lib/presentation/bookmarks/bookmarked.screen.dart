import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/bookmarks.controller.dart';

class BookmarkedLocationsScreen extends ConsumerWidget {
  const BookmarkedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarked = ref.watch(bookmarkedLocationsProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(bookmarkedLocationsProvider);
        },
        child: bookmarked.when(
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
        ),
      ),
    );
  }
}
