import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
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
      postfix: location.maybeWhen(
        data: (data) {
          if (data.isEmpty) return null;

          return IconButton(
            onPressed: () => context.router.navigate(const ShowMoreNearbyRoute()),
            icon: const Icon(Feather.arrow_right),
          );
        },
        error: (_, __) => null,
        loading: () => null,
        orElse: () => null,
      ),
      child: SizedBox(
        width: size.width,
        height: 215,
        child: location.maybeWhen(
          data: (data) {
            if (data.isEmpty) {
              return BlankSectionWidget(
                message: LocaleKeys.empty_result_set.tr(),
                icon: Icons.search_off_rounded,
              );
            }
            return NearbyListViewBuilder(
              items: data.getRange(0, 10).toList(),
              showMoreCallback: () => context.router.navigate(const ShowMoreNearbyRoute()),
              showDistance: true,
            );
          },
          error: (error, stackTrace) {
            final message = error is Failure ? error.message.tr() : error.toString();

            return BlankSectionWidget(
              message: message.tr(),
              icon: Icons.location_on_outlined,
            );
          },
          loading: () => _loadingList(context),
          orElse: () => BlankSectionWidget(message: LocaleKeys.sth_went_wrong.tr()),
        ),
      ),
    );
  }

  Widget _loadingList(BuildContext context, {int itemsToLoad = 5}) {
    return ScrollbarWrapperWidget(
      builder: (ctx, controller) => ListView.separated(
        controller: controller,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemsToLoad,
        itemBuilder: (_, index) {
          return const NearbyCardLoadingWidget();
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }
}
