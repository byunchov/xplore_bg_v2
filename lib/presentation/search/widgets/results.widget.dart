import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/presentation/search/controllers/search.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

/*
class SearchResultsWidget extends ConsumerWidget {
  const SearchResultsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(locationSearchProvider);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: results.when(
        data: ((data) {
          return Visibility(
            visible: data.isNotEmpty,
            child: ListView.separated(
              itemCount: data.length,
              itemBuilder: (contex, index) {
                return PlaceListTile(placePreview: data[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 15);
              },
            ),
            replacement: const BlankPage(
              icon: Icons.search_off_outlined,
              heading: 'no_places_found',
              shortText: 'try_again',
            ),
          );
        }),
        error: (err, stack) => Center(child: Text("Error: $err")),
        loading: () => _loadingState(),
      ),
    );
  }

  Widget _loadingState() {
    const item = PLaceTileLoadingWidget();
    final itemCount = (Get.height - Get.statusBarHeight) / item.cardHeight;

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount.ceil(),
      itemBuilder: (contex, index) {
        return item;
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }
}
*/

class SearchResultsWidget extends ConsumerWidget {
  const SearchResultsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(locationSearchProvider);
    return results.when(
      data: ((data) {
        return Visibility(
          visible: data.isNotEmpty,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: data.length,
            itemBuilder: (contex, index) {
              return PlaceListTile(placePreview: data[index]);
            },
            // separatorBuilder: (BuildContext context, int index) {
            //   return Container(height: 15, color: Colors.transparent);
            // },
          ),
          replacement: BlankPage(
            icon: Icons.search_off_outlined,
            heading: LocaleKeys.no_places_found.tr(),
            shortText: 'try_again',
          ),
        );
      }),
      error: (err, stack) => Center(child: Text("Error: $err")),
      loading: () => _loadingState(context),
    );
  }

  Widget _loadingState(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const item = PLaceTileLoadingWidget();
    final itemCount = (size.height - kToolbarHeight) / item.cardHeight;

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: itemCount.ceil(),
      itemBuilder: (contex, index) {
        return item;
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }
}
