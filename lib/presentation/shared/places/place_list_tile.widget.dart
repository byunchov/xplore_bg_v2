import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/place.model.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

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
