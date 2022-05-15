import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/gallery.provider.dart';

class GalleryScreen extends ConsumerStatefulWidget {
  // final PageController pageController;
  final int index;
  final String id;

  const GalleryScreen({
    Key? key,
    @PathParam() required this.id,
    @PathParam() this.index = 0,
  }) : super(key: key);

  @override
  ConsumerState<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends ConsumerState<GalleryScreen> {
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
    final gallery = ref.watch(galleryStateProvider(widget.id));

    return Scaffold(
      body: gallery.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          return Stack(
            alignment: Alignment.bottomLeft,
            children: [
              PhotoViewGallery.builder(
                pageController: _pageController,
                itemCount: data.itemCount,
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (ctx, index) {
                  final imgUrl = data.items[index].url;
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
              ...GalleryOverlayWidgets.backButtonAndGalleryStatsOverlay(
                context,
                currentIndex: _index + 1,
                totalItems: data.itemCount,
                author: data.items[_index].author,
                showCurrentPosition: true,
              ),
            ],
          );
        },
        error: (e, stk) => BlankPage(
          icon: Icons.error_outline_rounded,
          heading: "Error",
          shortText: e.toString(),
        ),
      ),
    );
  }
}
