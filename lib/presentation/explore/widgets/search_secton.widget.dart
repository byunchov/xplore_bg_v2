import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/models/swipe_action.model.dart';
import 'package:xplore_bg_v2/presentation/explore/controllers/explore.controller.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/note_action.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class SortableSectionWidget extends ConsumerWidget {
  const SortableSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SectionWithTitleWidget(
      title: DropdownButton<LocationSortType>(
        style: theme.textTheme.titleLarge,
        underline: const SizedBox.shrink(),
        value: ref.watch(locationSortTypeProvider),
        items: [
          DropdownMenuItem(
            child: Text(LocaleKeys.most_popular.tr()),
            value: LocationSortType.rating,
          ),
          DropdownMenuItem(
            child: Text(LocaleKeys.most_visited.tr()),
            value: LocationSortType.review_count,
          ),
          DropdownMenuItem(
            child: Text(LocaleKeys.most_liked.tr()),
            value: LocationSortType.like_count,
          ),
        ],
        onChanged: (value) {
          ref.read(locationSortTypeProvider.notifier).state = value!;
        },
      ),
      postfix: IconButton(
        onPressed: () {
          ref.refresh(locationSortProvider);
        },
        icon: const Icon(Icons.refresh),
      ),
      child: ref.watch(locationSortProvider).when(
            data: (data) => ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: data.length,
              itemBuilder: (ctx, index) {
                final place = data[index];
                return PlaceSwipeListTile(
                  placePreview: place,
                  actions: [
                    SwipeActionModel(
                      child: SwipeActionButton(
                        id: place.id,
                        field: 'bookmark_count',
                        iconStyle: BookmarkIcon(colorBold: Colors.white),
                        color: Colors.blue,
                      ),
                      onTap: () async {
                        await ref.read(bookmarkLocationProvider).bookmarkLocation(place.id);
                      },
                    ),
                    SwipeActionModel(
                      child: SwipeActionButton(
                        id: place.id,
                        field: 'like_count',
                        iconStyle: LikeIcon(colorBold: Colors.white),
                        color: Colors.red,
                      ),
                      onTap: () async {
                        await ref.read(bookmarkLocationProvider).likeLocation(
                          place.id,
                          onSuccess: (noted) {
                            SnackbarUtils.showSnackBar(
                              context,
                              snackBarType: SnackBarType.info,
                              message: (noted
                                      ? LocaleKeys.favourite_added
                                      : LocaleKeys.favourite_removed)
                                  .tr(namedArgs: {'name': place.name}),
                            );
                          },
                        );
                      },
                    ),
                  ],
                );
              },
              separatorBuilder: (ctx, index) => const SizedBox(width: 12),
            ),
            error: (error, stackTrace) => Text("Error: $error"),
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
          ),
    );
  }
}
