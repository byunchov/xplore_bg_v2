import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class NearbyListViewBuilder extends StatelessWidget {
  const NearbyListViewBuilder(
      {Key? key,
      this.items,
      this.itemsToShow = 10,
      this.loadingItems = 5,
      this.showMoreCallback,
      this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      this.hideShowMoreCard = false,
      this.showDistance = false})
      : super(key: key);

  final List<PlaceModel>? items;
  final int itemsToShow;
  final int loadingItems;
  final EdgeInsets padding;
  // final void Function(String id)? showMoreCallback;
  final VoidCallback? showMoreCallback;
  final bool hideShowMoreCard;
  final bool showDistance;

  @override
  Widget build(BuildContext context) {
    final itemCount = (items != null)
        ? ((items!.length < itemsToShow) ? items!.length : items!.length + 1)
        : loadingItems;

    return ScrollbarWrapperWidget(
      builder: (ctx, controller) => ListView.separated(
        controller: controller,
        padding: padding,
        physics:
            (items != null) ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (_, index) {
          if (items != null) {
            if (index == items!.length) {
              return hideShowMoreCard
                  ? const SizedBox.shrink()
                  : NearbyShowMoreCardWidget(onPressed: showMoreCallback);
            }
            return NearbyCardWidget(place: items![index], useGeolocator: showDistance);
          }
          return const NearbyCardLoadingWidget();
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }
}
