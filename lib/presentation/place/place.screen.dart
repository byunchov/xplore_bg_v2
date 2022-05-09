import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/location/location.screen.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/note_action.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/places/details/activities_body.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'controllers/place.provider.dart';

class PlaceDetailsScreen extends HookConsumerWidget {
  final PlaceModel place;
  final Animation<double>? transitionAnimation;
  final String heroTag;

  const PlaceDetailsScreen({
    Key? key,
    required this.place,
    required this.heroTag,
    this.transitionAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    ref.watch(placeProvider(place.id).select((value) => null));

    log(place.id, name: runtimeType.toString());

    return LocationDetailsScreen(
      scrollController: scrollController,
      location: place,
      heroTag: heroTag,
      slivers: [
        SliverToBoxAdapter(
          child: LocationGallerySection(locationId: place.id),
        ),
        SliverToBoxAdapter(
          child: _DescriptionSection(locationId: place.id),
        ),
        SliverToBoxAdapter(
          child: _ActivitySection(place: place),
        ),
        SliverToBoxAdapter(
          child: _NearbySection(place.id),
        ),
      ],
      bottomNavigationBar: _AutoHideBottomActionBar(
        id: place.id,
        scrollController: scrollController,
      ),
    );
  }
}

class _AutoHideBottomActionBar extends ConsumerWidget {
  const _AutoHideBottomActionBar({
    Key? key,
    required this.scrollController,
    required this.id,
  }) : super(key: key);

  final ScrollController scrollController;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScrollToHideWidget(
      controller: scrollController,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          NotedActionIconButton(
            id: id,
            field: 'like_count',
            iconStyle: LikeIcon(),
            onPressed: () async {
              await ref.read(bookmarkLocationProvider).likeLocation(id);
            },
          ),
          NotedActionIconButton(
            id: id,
            field: 'bookmark_count',
            iconStyle: BookmarkIcon(),
            onPressed: () async {
              await ref.read(bookmarkLocationProvider).bookmarkLocation(id);
            },
          ),
          NotedActionIconButton(
            id: id,
            field: 'review_count',
            iconStyle: const Icon(LineIcons.comments),
            onPressed: () async {
              context.router.navigate(PlaceReviewsRoute(locId: id));
            },
          ),
        ],
      ),
    );
  }
}

class _DescriptionSection extends ConsumerWidget {
  const _DescriptionSection({
    Key? key,
    required this.locationId,
  }) : super(key: key);

  final String locationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final details = ref.watch(placeDetailsProvider(locationId));

    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.section_description.tr()),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: details.when(
          data: (data) {
            if (data == null) {
              return const Text("No description found.");
            }
            return ExpandText(
              data.description ?? "",
              maxLines: 8,
              collapsedHint: LocaleKeys.show_more.tr(),
              expandedHint: LocaleKeys.show_less.tr(),
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 17),
              textAlign: TextAlign.justify,
              expandArrowStyle: ExpandArrowStyle.both,
              arrowSize: 25,
              arrowColor: Theme.of(context).primaryColor,
              arrowPadding: const EdgeInsets.only(top: 5),
              hintTextStyle: TextStyle(color: theme.primaryColor),
            );
          },
          error: (err, stack) {
            return Container();
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class _ActivitySection extends StatelessWidget {
  const _ActivitySection({
    Key? key,
    required this.place,
  }) : super(key: key);

  final PlaceModel place;

  @override
  Widget build(BuildContext context) {
    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.section_activities.tr()),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: PlaceActivitiesBody(place: place),
      ),
    );
  }
}

class _NearbySection extends ConsumerWidget {
  const _NearbySection(this.locId, {Key? key}) : super(key: key);

  final String locId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nearby = ref.watch(placeNearbyLocationsProvider(locId));

    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.section_nearby.tr()),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: SizedBox(
          width: double.infinity,
          height: 215,
          // color: Colors.blue,
          child: nearby.when(
            data: (data) => NearbyListViewBuilder(items: data, hideShowMoreCard: true),
            error: (error, stackTrace) => Text("Error: $error"),
            loading: () => const NearbyListViewBuilder(),
          ),
        ),
      ),
    );
  }
}
