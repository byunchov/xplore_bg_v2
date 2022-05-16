import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/gallery/controllers/gallery.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class GalleryListViewWidget extends ConsumerWidget {
  const GalleryListViewWidget({
    Key? key,
    required this.locId,
  }) : super(key: key);

  final String locId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderRadius = WidgetConstants.kCradBorderRadius;
    final gallery = ref.watch(galleryStateProvider(locId));

    log(locId, name: runtimeType.toString());

    return SizedBox(
      height: 150,
      child: gallery.when(
        loading: () => const GalleryListViewWLoadingWidget(),
        data: (data) {
          if (data.itemCount == 0) {
            return BlankSectionWidget(
              message: LocaleKeys.empty_gallery.tr(),
              icon: Icons.broken_image_outlined,
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: data.itemCount,
            itemBuilder: (_, index) => LayoutBuilder(builder: (ctx, constraints) {
              final imgUrl = data.items[index].url;
              return Hero(
                tag: imgUrl,
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: InkWell(
                    onTap: () {
                      ctx.router.navigate(GalleryRoute(index: index, id: locId));
                    },
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
          );
        },
        error: (e, stk) => Text(e.toString()),
      ),
    );
  }
}
