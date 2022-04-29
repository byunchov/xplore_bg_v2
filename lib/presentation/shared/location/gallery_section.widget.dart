import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/loading/gallery_listview.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class LocationGallerySection<T> extends ConsumerWidget {
  const LocationGallerySection({
    Key? key,
    required this.provider,
    required this.locationId,
  }) : super(key: key);

  final String locationId;
  final AutoDisposeFutureProviderFamily<T, String> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(provider(locationId));

    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.section_nearby.tr()),
      child: details.when(
        data: (data) {
          if (data == null) {
            return Container();
          }
          if (data is LocationModel) {
            return GalleryListViewWidget(gallery: data.gallery!);
          }
          return Container();
        },
        error: (err, stack) {
          return Container();
        },
        loading: () => const GalleryListViewWLoadingWidget(),
      ),
    );
  }
}
