import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/domain/core/utils/navigation.util.dart';
import 'package:xplore_bg_v2/models/image.model.dart';
import 'package:xplore_bg_v2/presentation/gallery/gallery.screen.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class GalleryListViewWidget extends StatelessWidget {
  final List<ImageModel> gallery;
  const GalleryListViewWidget({
    Key? key,
    required this.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: gallery.length,
        itemBuilder: (ctx, index) => LayoutBuilder(builder: (ctx, constraints) {
          final imgUrl = gallery[index].url;
          return Hero(
            tag: imgUrl,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(WidgetConstants.kCradBorderRadius),
              child: InkWell(
                onTap: () => openPhotoViewGallery(context, index, gallery),
                borderRadius: BorderRadius.circular(WidgetConstants.kCradBorderRadius),
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
    );
  }
}
