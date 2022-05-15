import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/explore/controllers/explore.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class NearbySectionWidget extends ConsumerWidget {
  const NearbySectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final location = ref.watch(locationsNearbyProvider);

    return SectionWithTitleWidget(
      title: Text(
        LocaleKeys.section_nearby.tr(),
        style: theme.textTheme.titleLarge,
      ),
      // postfix: IconButton(onPressed: () {}, icon: const Icon(Feather.arrow_right)),
      postfix: location.maybeWhen(
        data: (data) {
          if (data.isEmpty) return null;

          return IconButton(
            onPressed: () => context.router.navigate(const ShowMoreNearbyRoute()),
            icon: const Icon(Feather.arrow_right),
          );
        },
        error: (error, stk) => null,
        loading: () => null,
        orElse: () => null,
      ),
      child: SizedBox(
        width: size.width,
        height: 215,
        // color: Colors.blue,
        child: location.maybeWhen(
            data: (data) {
              if (data.isEmpty) {
                return const BlankPage(heading: "No results");
              }
              return NearbyListViewBuilder(
                items: data.getRange(0, 10).toList(),
                showMoreCallback: () => context.router.navigate(const ShowMoreNearbyRoute()),
                showDistance: true,
              );
            },
            error: (error, stackTrace) => Text("Error: $error"),
            loading: () => _createList(context),
            orElse: () => const Text("orElse")),
      ),
    );
  }

  Widget _createList(BuildContext context, {List<PlaceModel>? items, int itemsToLoad = 5}) {
    final itemCount = items != null ? items.length + 1 : itemsToLoad;
    return ScrollbarWrapperWidget(
      builder: (ctx, controller) => ListView.separated(
        controller: controller,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        physics:
            (items != null) ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (_, index) {
          if (items != null) {
            if (index == items.length) {
              return const NearbyShowMoreCardWidget();
            }

            return NearbyCardWidget(place: items[index]);
          }

          return const NearbyCardLoadingWidget();
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }
}
