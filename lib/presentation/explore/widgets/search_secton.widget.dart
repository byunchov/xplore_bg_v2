import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/explore/controllers/explore.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class SortableSectionWidget extends ConsumerWidget {
  const SortableSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final previewList = ref.watch(locationSortProvider);

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
        icon: const Icon(Icons.refresh),
        onPressed: () {
          ref.refresh(locationSortProvider);
        },
      ),
      child: previewList.when(
        data: (data) {
          if (data.isEmpty) {
            return SizedBox(
              height: 150,
              child: BlankSectionWidget(
                message: LocaleKeys.empty_result_set.tr(),
                icon: Icons.search_off_rounded,
              ),
            );
          }

          return _DataList(data);
        },
        error: (error, stackTrace) {
          final message = error is Failure ? error.message.tr() : error.toString();

          return BlankSectionWidget(
            icon: Icons.error_outline_outlined,
            message: message,
          );
        },
        loading: () => const _LoadingList(),
      ),
    );
  }
}

class _DataList extends StatelessWidget {
  const _DataList(this.data, {Key? key}) : super(key: key);

  final List<PlaceModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      itemCount: data.length,
      itemBuilder: (ctx, index) {
        final place = data[index];
        return PlaceLikeBookmarkSwipeListTile(place: place);
      },
      separatorBuilder: (ctx, index) => const SizedBox(width: 12),
    );
  }
}

class _LoadingList extends StatelessWidget {
  const _LoadingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
    );
  }
}
