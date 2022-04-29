import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class GalleryListViewWidget extends StatelessWidget {
  final GalleryModel gallery;
  const GalleryListViewWidget({
    Key? key,
    required this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = WidgetConstants.kCradBorderRadius;
    return SizedBox(
      height: 150,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: gallery.itemCount,
        itemBuilder: (_, index) => LayoutBuilder(builder: (ctx, constraints) {
          final imgUrl = gallery.items[index].url;
          return Hero(
            tag: imgUrl,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(borderRadius),
              child: InkWell(
                onTap: () => ctx.router.navigate(GalleryRoute(gallery: gallery, index: index)),
                borderRadius: BorderRadius.circular(borderRadius),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
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
    );
  }
}
