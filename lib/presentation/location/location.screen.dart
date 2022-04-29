import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/location/location.model.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'widgets/header.widget.dart';

class LocationDetailsScreen extends StatelessWidget {
  final LocationModel location;
  final List<Widget> slivers;
  final Widget? bottomNavigationBar;
  final ScrollController scrollController;
  final String? heroTag;

  const LocationDetailsScreen({
    Key? key,
    required this.location,
    required this.slivers,
    required this.scrollController,
    this.heroTag,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Hero(
                  tag: heroTag ?? location.id,
                  child: SizedBox(
                    height: 300,
                    child: GestureDetector(
                      child: CustomCachedImage(imageUrl: location.thumbnail.url),
                      onTap: () =>
                          context.router.navigate(GalleryRoute(gallery: location.gallery!)),
                    ),
                  ),
                ),
                ...GalleryOverlayWidgets.backButtonAndGalleryStatsOverlay(
                  context,
                  author: location.thumbnail.author,
                  totalItems: 0,
                ),
              ],
            ),
          ),
          SliverPinnedHeader(
            child: LocationHeaderWidget(controller: scrollController, location: location),
          ),
          ...slivers,
        ],
      ),
      bottomNavigationBar: Material(child: bottomNavigationBar),
    );
  }
}
