import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class LocationGallerySection extends ConsumerWidget {
  const LocationGallerySection({
    Key? key,
    required this.locationId,
  }) : super(key: key);

  final String locationId;
  // final dynamic provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final details = ref.watch(provider(locationId));
    // final gallery = ref.watch(galleryStateProvider(locationId));

    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.section_gallery.tr()),
      child: GalleryListViewWidget(locId: locationId),
    );
  }
}
