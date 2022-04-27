import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/place.model.dart';
import 'package:xplore_bg_v2/models/swipe_action.model.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/bookmarks.controller.dart';
import 'package:xplore_bg_v2/presentation/place/widgets/action_icon_button.widget.dart';
import 'package:xplore_bg_v2/presentation/place/widgets/action_icons.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PlaceSwipeListTile extends StatelessWidget {
  final PlaceModel placePreview;
  final List<SwipeActionModel>? actions;
  final double widthSpace;

  const PlaceSwipeListTile({
    Key? key,
    required this.placePreview,
    this.actions,
    this.widthSpace = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwipeActionCell(
      key: UniqueKey(),
      trailingActions: actions?.map((action) {
        return SwipeAction(
          widthSpace: widthSpace,
          content: action.child,
          color: Colors.transparent,
          onTap: (CompletionHandler handler) async {
            // await handler(true);
            action.onTap?.call();
            await handler(false);
          },
        );
      }).toList(),
      child: PlaceListTile(
        placePreview: placePreview,
        onLongPress: () => _onLongPress(context),
      ),
    );
  }

  void _onLongPress(BuildContext context) {
    final theme = Theme.of(context);

    showDialog(
        context: context,
        builder: (_) {
          return Consumer(
            builder: (ctx, ref, __) {
              return Center(
                child: Container(
                  // height: 160,
                  width: Get.width * 0.8,
                  padding: const EdgeInsets.all(32),
                  // margin: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: theme.dialogTheme.backgroundColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePreview.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ActionIconButton(
                            id: placePreview.id,
                            field: 'like_count',
                            iconStyle: LikeIcon(),
                            onPressed: () async {
                              await ref
                                  .read(bookmarkLocationProvider)
                                  .likeLocation(placePreview.id);
                            },
                          ),
                          ActionIconButton(
                            id: placePreview.id,
                            field: 'bookmark_count',
                            iconStyle: BookmarkIcon(),
                            onPressed: () async {
                              await ref
                                  .read(bookmarkLocationProvider)
                                  .bookmarkLocation(placePreview.id);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  Widget _getActionButton(Color color, IconData icon, [double? iconRadius]) {
    final radius = iconRadius ?? 25;
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}

class PlaceListTile extends StatelessWidget {
  const PlaceListTile({
    Key? key,
    required this.placePreview,
    this.cardHeight = 140,
    this.cardBorderRadius = WidgetConstants.kCradBorderRadius,
    this.elevation = 4,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final double cardHeight;
  final double cardBorderRadius;
  final PlaceModel placePreview;
  final double elevation;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final heroTag = UniqueKey().toString();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(cardBorderRadius),
        child: Container(
          height: cardHeight,
          // margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.listTileTheme.tileColor,
            borderRadius: BorderRadius.circular(cardBorderRadius),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap ??
                  () {
                    context
                        .pushRoute(LocationRouter(children: [LocationRoute(place: placePreview)]));
                  },
              onLongPress: onLongPress,
              borderRadius: BorderRadius.circular(cardBorderRadius),
              child: Row(
                children: [
                  Hero(
                    tag: heroTag,
                    child: SizedBox(
                      height: cardHeight,
                      width: cardHeight - 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(cardBorderRadius),
                          bottomLeft: Radius.circular(cardBorderRadius),
                        ),
                        child: CustomCachedImage(imageUrl: placePreview.thumbnail.url),
                      ),
                    ),
                  ),
                  // const SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              // "Name of place with long text here#",
                              placePreview.name,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge?.copyWith(fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.location_pin,
                                size: 15,
                              ),
                              const SizedBox(width: 2.6),
                              Expanded(
                                child: Text(
                                  placePreview.residence.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.textTheme.labelLarge,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Text(
                            placePreview.subcategory.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium,
                          ),
                          CustomDivider(
                            width: size.width * 0.22,
                            height: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _statisticsItem(
                                theme,
                                LineIcons.starAlt,
                                "${placePreview.rating} (${placePreview.reviewsCount})",
                                iconColor: Colors.amber[700],
                              ),
                              const SizedBox(width: 10),
                              _statisticsItem(
                                theme,
                                LineIcons.heartAlt,
                                placePreview.likesCount.toString(),
                                iconColor: Colors.red[800],
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statisticsItem(ThemeData theme, IconData icon, String count, {Color? iconColor}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 15,
          color: iconColor ?? theme.primaryColor,
        ),
        const SizedBox(width: 5),
        Text(
          count,
          style: theme.textTheme.labelMedium,
        ),
      ],
    );
  }
}
