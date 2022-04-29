import 'package:auto_route/auto_route.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';

import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/location/location.screen.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/note_action.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/place.provider.dart';
import 'widgets/activities_body.widget.dart';

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
    final theme = Theme.of(context);

    print(context.router.routeData.path);

    return LocationDetailsScreen(
      scrollController: scrollController,
      location: place,
      heroTag: heroTag,
      slivers: [
        SliverToBoxAdapter(
          child: LocationGallerySection(locationId: place.id, provider: placeDetailsProvider),
        ),
        SliverToBoxAdapter(
          child: _DescriptionSection(locationId: place.id, provider: placeDetailsProvider),
        ),
        SliverToBoxAdapter(
          child: SectionWithTitleWidget(
            title: const SectionTitleWithDividerWidget("Activities"),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: PlaceActivitiesBody(
                coordinates: place.coordinates!,
                place: place,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SectionWithTitleWidget(
            title: const SectionTitleWithDividerWidget("Nearby"),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) => Container(
                    width: 100,
                    color: Colors.green,
                  ),
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10),
                ),
              ),
            ),
          ),
        ),
      ],
      bottomNavigationBar: ScrollToHideWidget(
        controller: scrollController,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NotedActionIconButton(
              id: place.id,
              field: 'like_count',
              iconStyle: LikeIcon(),
              onPressed: () async {
                await ref.read(bookmarkLocationProvider).likeLocation(place.id);
              },
            ),
            NotedActionIconButton(
              id: place.id,
              field: 'bookmark_count',
              iconStyle: BookmarkIcon(),
              onPressed: () async {
                await ref.read(bookmarkLocationProvider).bookmarkLocation(place.id);
              },
            ),
            NotedActionIconButton(
              id: place.id,
              field: 'review_count',
              iconStyle: const Icon(LineIcons.comments),
              onPressed: () async {},
            ),
          ],
        ),
      ),
    );
  }

/* 
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Hero(
                  tag: place.id,
                  child: SizedBox(
                    height: 300,
                    child: GestureDetector(
                      child: CustomCachedImage(imageUrl: place.thumbnail.url),
                      onTap: () => openGallery(0),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: SafeArea(
                    child: AnimatedBuilder(
                      animation: transitionAnimation,
                      builder: (context, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, -4),
                            end: const Offset(0, 0),
                          ).animate(
                            CurvedAnimation(
                              curve: const Interval(0.7, 1, curve: Curves.easeInCubic),
                              parent: transitionAnimation,
                            ),
                          ),
                          child: child,
                        );
                      },
                      child: AppbarActionWidget(
                        iconData: Icons.arrow_back,
                        buttonSize: 42,
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: GalleryStatsWidget(
                    currentIndex: 1,
                    totalItems: place.gallery!.length,
                    showCurrentPosition: false,
                  ),
                ),
              ],
            ),
          ),
          SliverPinnedHeader(
            child: LocationHeaderWidget(controller: _scrollController, location: place),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: _sectionTitle("Gallery", theme),
              child: SizedBox(
                height: 150,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: place.gallery!.length,
                  itemBuilder: (ctx, index) => LayoutBuilder(builder: (ctx, constraints) {
                    final imgUrl = place.gallery![index].url;
                    return Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(WidgetConstants.kCradBorderRadius),
                      child: InkWell(
                        onTap: () => openGallery(index),
                        borderRadius: BorderRadius.circular(WidgetConstants.kCradBorderRadius),
                        child: Hero(
                          tag: imgUrl,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(WidgetConstants.kCradBorderRadius),
                            child: CustomCachedImage(
                              imageUrl: imgUrl,
                              width: constraints.maxHeight,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 12),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: _sectionTitle("Description", theme),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ExpandText(
                  // "kdmi eidemkmdieufeokmfeiof",
                  place.description ?? "",
                  maxLines: 8,
                  collapsedHint: "show_more",
                  expandedHint: "show_less",
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 17),
                  textAlign: TextAlign.justify,
                  expandArrowStyle: ExpandArrowStyle.both,
                  arrowSize: 25,
                  arrowColor: Theme.of(context).primaryColor,
                  arrowPadding: const EdgeInsets.only(top: 5),
                  hintTextStyle: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: _sectionTitle("Activities", theme),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: _PlaceActivitiesBody(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SectionWithTitleWidget(
              title: _sectionTitle("Nearby", theme),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      width: 100,
                      color: Colors.green,
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(width: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ScrollToHideWidget(
        controller: _scrollController,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Icon(Icons.heart_broken),
                Text("Likes"),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.bookmarks),
                Text("Bookmarks"),
              ],
            ),
            Column(
              children: const [
                Icon(Icons.reviews_outlined),
                Text("Reviews"),
              ],
            ),
          ],
        ),
      ),
    );
  }
 */

}

class _DescriptionSection<T> extends ConsumerWidget {
  const _DescriptionSection({
    Key? key,
    required this.provider,
    required this.locationId,
  }) : super(key: key);

  final String locationId;
  final AutoDisposeFutureProviderFamily<T, String> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final details = ref.watch(provider(locationId));

    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.section_description.tr()),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: details.when(
          data: (data) {
            if (data == null) {
              return Container();
            }
            if (data is PlaceModel) {
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
                hintTextStyle: TextStyle(color: Theme.of(context).primaryColor),
              );
            }
            return Container();
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
