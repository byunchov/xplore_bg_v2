import 'package:auto_route/auto_route.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';

import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/place.model.dart';
import 'package:xplore_bg_v2/presentation/location/location.screen.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/bookmarks.controller.dart';
import 'package:xplore_bg_v2/presentation/place/widgets/activities.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'widgets/action_icon_button.widget.dart';
import 'widgets/action_icons.dart';

class PlaceDetailsScreen extends HookConsumerWidget {
  final PlaceModel place;
  final Animation<double>? transitionAnimation;
  const PlaceDetailsScreen({
    Key? key,
    required this.place,
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
      slivers: [
        SliverToBoxAdapter(
          child: SectionWithTitleWidget(
            title: const SectionTitleWithDividerWidget("Gallery"),
            child: GalleryListViewWidget(gallery: place.gallery!),
          ),
        ),
        SliverToBoxAdapter(
          child: SectionWithTitleWidget(
            title: const SectionTitleWithDividerWidget("Description"),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: ExpandText(
                // "kdmi eidemkmdieufeokmfeiof",
                place.description ?? "",
                maxLines: 8,
                collapsedHint: tr("show_more"),
                expandedHint: tr("show_less"),
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
            title: const SectionTitleWithDividerWidget("Activities"),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: _PlaceActivitiesBody(
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
            ActionIconButton(
              id: place.id,
              field: 'like_count',
              iconStyle: LikeIcon(),
              onPressed: () async {
                await ref.read(bookmarkLocationProvider).likeLocation(place.id);
              },
            ),
            ActionIconButton(
              id: place.id,
              field: 'bookmark_count',
              iconStyle: BookmarkIcon(),
              onPressed: () async {
                await ref.read(bookmarkLocationProvider).bookmarkLocation(place.id);
              },
            ),
            ActionIconButton(
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

class _PlaceActivitiesBody extends StatelessWidget {
  final LatLng coordinates;
  final PlaceModel place;
  const _PlaceActivitiesBody({
    Key? key,
    required this.coordinates,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(coordinates.toString());
    String maptTile = "https://maps.googleapis.com/maps/api/staticmap?center=41.83458,23.48632"
        "&zoom=14&size=600x200&scale=2&markers=color:red|${coordinates.latitude},${coordinates.longitude}"
        "&language=bg&key=${AppConfig.mapsAPIKey}";

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PlaceActivitiyColorCard(
                  text: LocaleKeys.nearby_rest.tr(),
                  color: Colors.orange[300]!,
                  icon: Icons.restaurant_menu,
                  callback: () {
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => RestaurantsScreen(place)));
                    context.pushRoute(
                        RestaurantsRouter(children: [RestaurantsRoute(location: place)]));
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: PlaceActivitiyColorCard(
                  text: LocaleKeys.nearby_hotels.tr(),
                  color: Colors.blueAccent[400]!,
                  icon: Icons.hotel_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          PlaceActivityImageCard(
            text: "",
            icon: Icons.navigation_rounded,
            image: CustomCachedImage(
              imageUrl: maptTile,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
