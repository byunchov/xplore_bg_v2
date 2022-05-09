import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class NearbyListViewBuilder extends StatelessWidget {
  const NearbyListViewBuilder({
    Key? key,
    this.items,
    this.itemsToShow = 10,
    this.loadingItems = 5,
    this.shoMoreCallback,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    this.hideShowMoreCard = false,
  }) : super(key: key);

  final List<PlaceModel>? items;
  final int itemsToShow;
  final int loadingItems;
  final EdgeInsets padding;
  final void Function(String id)? shoMoreCallback;
  final bool hideShowMoreCard;

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
              return hideShowMoreCard ? const SizedBox.shrink() : const NearbyShowMoreCardWidget();
            }
            return NearbyCardWidget(place: items![index]);
          }
          return const NearbyCardLoadingWidget();
        },
        separatorBuilder: (_, __) => const SizedBox(width: 12),
      ),
    );
  }
}
