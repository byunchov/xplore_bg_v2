import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/models/location/place.model.dart';
import 'package:xplore_bg_v2/models/swipe_action.model.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/appbar_avatar.widget.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/featured_card.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/places/nearby/nearby_card.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/places/nearby/show_more_nearby.widget.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/note_action.controller.dart';
import 'package:xplore_bg_v2/presentation/search/controllers/search.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:auto_route/auto_route.dart';

enum LocationSortType {
  popular,
  visited,
  liked,
}

final locationSortTypeProvider = StateProvider<LocationSortType>((ref) => LocationSortType.popular);

final locationSortProvider = FutureProvider.autoDispose<List<PlaceModel>>((ref) async {
  final sortType = ref.watch(locationSortTypeProvider);

  final index = await ref.read(searchClientProvider).getIndex('locations');
  final sortField = StringBuffer();

  switch (sortType) {
    case LocationSortType.popular:
      sortField.write("rating");
      break;
    case LocationSortType.visited:
      sortField.write("review_count");
      break;
    case LocationSortType.liked:
      sortField.write("like_count");
      break;
    default:
      sortField.write("rating");
  }
  final searchResult = await index.search(
    "",
    limit: 5,
    filter: ['lang = "bg"'],
    sort: ["${sortField.toString()}:desc"],
  );
  return searchResult.hits!.map((e) => PlaceModel.previewFromJson(e)).toList();
});

final locationsNearbyProvider = FutureProvider<List<PlaceModel>>((ref) async {
  final index = await ref.read(searchClientProvider).getIndex('locations');
  final searchResult = await index.search(
    "",
    limit: 10,
    filter: ['lang = "bg"'],
    sort: ["_geoPoint(41.84126118480892, 23.48859392410678):asc"],
  );
  // return searchResult.hits!.map((e) => PlaceModel.previewFromJson(e)).toList();
  return searchResult.hits!.map((e) => PlaceModel.formJson(e)).toList();
});

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return const [
              _MainAppBar(),
              _SearchBoxAppBar(),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(locationsNearbyProvider);
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  _FeauturedSection(),
                  _NearbySection(),
                  _SortableSection(),
                  _NearbySection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MainAppBar extends StatelessWidget {
  const _MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      toolbarHeight: 110,
      backgroundColor: AppThemes.xploreAppbarColor(theme.brightness),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppConfig.appName,
                  style: theme.textTheme.headline5?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(
                  "app_description",
                  style: theme.textTheme.subtitle2,
                ).tr(),
                // const SizedBox(height: 20),
              ],
            ),
            const Spacer(),
            AppbarAvatarIcon(
              // onTap: () =>
              //     context.pushRoute(const HomeRoute(children: [UserProfileRoute()])),
              onTap: () => context.navigateTo(const UserProfileRoute()),
              profilePic: AppConfig.defaultProfilePic,
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBoxAppBar extends StatelessWidget {
  const _SearchBoxAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      toolbarHeight: 80,
      floating: true,
      pinned: true,
      centerTitle: true,
      forceElevated: true,
      backgroundColor: AppThemes.xploreAppbarColor(theme.brightness),
      automaticallyImplyLeading: false,
      title: const SearchBarWidget(),
    );
  }
}

class _FeauturedSection extends ConsumerWidget {
  const _FeauturedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SectionWithTitleWidget(
      title: Text(
        "Препоръчани",
        style: theme.textTheme.titleLarge,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          return ref.watch(locationsNearbyProvider).when(
                data: (data) => SizedBox(
                  height: 280,
                  width: size.width,
                  child: CarouselSliderWidget(
                    autoPlay: false,
                    viewportFraction: 0.9,
                    children: data.map((e) => FeaturedCardWidget(place: e)).toList(),
                  ),
                ),
                error: (err, stack) => Text("Error: $err"),
                loading: () => const Center(child: CircularProgressIndicator()),
              );
        },
      ),
    );
  }
}

class _NearbySection extends ConsumerWidget {
  const _NearbySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SectionWithTitleWidget(
      title: Text(
        LocaleKeys.section_nearby.tr(),
        style: theme.textTheme.titleLarge,
      ),
      postfix: IconButton(onPressed: () {}, icon: const Icon(Feather.arrow_right)),
      child: SizedBox(
        width: size.width,
        height: 215,
        // color: Colors.blue,
        child: ref.watch(locationsNearbyProvider).when(
              data: (data) => _createList(context, items: data),
              error: (error, stackTrace) => Text("Error: $error"),
              loading: () => _createList(context),
            ),
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

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({Key? key, this.radius = 8}) : super(key: key);
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "@searchWidget",
      child: InkWell(
        onTap: (() => context.router.navigate(const SearchRoute())),
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.7),
            borderRadius: BorderRadius.circular(radius),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Icon(
                  LineIcons.search,
                  size: 20,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 10),
                Text(
                  LocaleKeys.search_places,
                  style: TextStyle(color: Colors.grey[700], fontSize: 15),
                ).tr(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SortableSection extends ConsumerWidget {
  const _SortableSection({
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
        items: const [
          DropdownMenuItem(
            child: Text("Най-популярни"),
            value: LocationSortType.popular,
          ),
          DropdownMenuItem(
            child: Text("Най-посещавани"),
            value: LocationSortType.visited,
          ),
          DropdownMenuItem(
            child: Text("Най-харесвани"),
            value: LocationSortType.liked,
          ),
        ],
        onChanged: (value) {
          ref.read(locationSortTypeProvider.notifier).state = value!;
        },
      ),
      postfix: IconButton(
        onPressed: () {
          SnackbarUtils.showSnackBar(
            context,
            title: "Title",
            message: "Test content",
            snackBarType: SnackBarType.info,
          );
        },
        icon: const Icon(Feather.arrow_right),
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
