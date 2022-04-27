import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:xplore_bg_v2/domain/core/utils/navigation.util.dart';
import 'package:xplore_bg_v2/models/location.model.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'widgets/header.widget.dart';

class LocationDetailsScreen extends StatelessWidget {
  final LocationModel location;
  final List<Widget> slivers;
  final Widget? bottomNavigationBar;
  final ScrollController scrollController;
  const LocationDetailsScreen({
    Key? key,
    required this.location,
    required this.slivers,
    required this.scrollController,
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
                  tag: location.id,
                  child: SizedBox(
                    height: 300,
                    child: GestureDetector(
                      child: CustomCachedImage(imageUrl: location.thumbnail.url),
                      onTap: () => openPhotoViewGallery(context, 0, location.gallery!),
                    ),
                  ),
                ),
                ...GalleryOverlayWidgets.backButtonAndGalleryStatsOverlay(
                  context,
                  0,
                  author: location.thumbnail.author,
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
