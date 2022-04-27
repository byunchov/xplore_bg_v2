import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:xplore_bg_v2/models/image.model.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets/appbar_action.widget.dart';

import 'widgets/gallery_stats.widget.dart';

class GalleryScreen extends StatefulWidget {
  // final PageController pageController;
  final List<ImageModel> gallery;
  final int index;

  const GalleryScreen({
    Key? key,
    required this.gallery,
    this.index = 0,
  }) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late int _index;
  late final PageController _pageController;

  @override
  void initState() {
    _index = widget.index;
    _pageController = PageController(initialPage: _index);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          PhotoViewGallery.builder(
            pageController: _pageController,
            itemCount: widget.gallery.length,
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (ctx, index) {
              final imgUrl = widget.gallery[index].url;
              return PhotoViewGalleryPageOptions(
                imageProvider: CachedNetworkImageProvider(imgUrl),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.contained * 3,
                heroAttributes: PhotoViewHeroAttributes(tag: imgUrl),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _index = index;
              });
            },
          ),
          Positioned(
            top: 20,
            left: 20,
            child: SafeArea(
              child: AppbarActionWidget(
                iconData: Icons.arrow_back,
                buttonSize: 42,
                onTap: () => Navigator.pop(context),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: GalleryStatsWidget(
              currentIndex: _index + 1,
              totalItems: widget.gallery.length,
            ),
          ),
        ],
      ),
    );
  }
}
