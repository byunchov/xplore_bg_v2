import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/location/place.model.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class FeaturedCardWidget extends StatelessWidget {
  final PlaceModel place;
  final double elevation;

  const FeaturedCardWidget({
    Key? key,
    required this.place,
    this.elevation = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const radius = WidgetConstants.kCradBorderRadius;

    final heroTag = UniqueKey().toString();

    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        borderRadius: BorderRadius.circular(radius),
        elevation: elevation,
        color: theme.listTileTheme.tileColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            final router = AutoRouterDelegate.of(context).controller;
            router.navigate(
                LocationRouter(children: [LocationRoute(place: place, heroTag: heroTag)]));
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              // color: theme.listTileTheme.tileColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, bodyConstraints) {
                    return Material(
                      borderRadius: BorderRadius.circular(radius),
                      elevation: elevation,
                      child: Hero(
                        tag: heroTag,
                        child: Container(
                          width: bodyConstraints.maxWidth,
                          height: constraints.maxHeight * 0.72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(place.thumbnail.url),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 42,
                                  alignment: Alignment.center,
                                  width: bodyConstraints.maxWidth * 0.8 - radius * 2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900]?.withOpacity(0.92),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      bottomRight: Radius.circular(radius),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _statisticsItem(
                                        context,
                                        LineIcons.starAlt,
                                        "${place.rating.toString()} (${place.reviewsCount.toString()})",
                                        iconColor: Colors.amber,
                                      ),
                                      _statisticsItem(
                                        context,
                                        LineIcons.heartAlt,
                                        place.likesCount.toString(),
                                        iconColor: Colors.red[600]!,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 9),
                Expanded(
                  child: Center(
                    child: Text(
                      place.name.toString(),
                      // "dklqmdoie lcel m 'plekfwe,mdpwqlodl[pqw;l d,owql,lkwmikl,dmqw'dooqw,d'wqkdoikemfiuwhdqwijdiuwqkkdijqwh",
                      maxLines: 2,
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _statisticsItem(BuildContext context, IconData icon, String count, {Color? iconColor}) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Icon(
            icon,
            size: constraints.maxHeight * 0.55,
            color: iconColor ?? Theme.of(context).primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            count,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
          ),
        ],
      );
    });
  }
}

class FeaturedCardWidget2 extends StatelessWidget {
  final PlaceModel place;
  const FeaturedCardWidget2({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: InkWell(
        child: Stack(
          children: [
            Hero(
              tag: 'featured${place.id}',
              child: Container(
                height: 220,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    // border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300]!,
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomCachedImage(imageUrl: place.thumbnail.url),
                ),
              ),
            ),
            Positioned(
              height: 120,
              width: width * 0.70,
              left: width * 0.11,
              bottom: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey[300]!,
                      offset: const Offset(0, 2),
                      blurRadius: 3,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        // "Title with long text content here!",
                        place.name,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[850],
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                            size: 15,
                          ),
                          const SizedBox(width: 2.5),
                          Expanded(
                            child: Text(
                              // "Location with long text content here!",
                              place.region ?? "region",
                              maxLines: 1,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w400,
                                fontSize: 12.5,
                              ),
                            ),
                          )
                        ],
                      ),
                      CustomDivider(
                          height: 2,
                          width: width * 0.25,
                          margin: const EdgeInsets.symmetric(vertical: 10)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            statisticsItem(
                              context,
                              LineIcons.star,
                              "${place.rating.toString()} (${place.reviewsCount.toString()})",
                              iconColor: Colors.amber,
                            ),
                            const SizedBox(width: 10),
                            statisticsItem(
                              context,
                              LineIcons.heart,
                              place.likesCount.toString(),
                              iconColor: Colors.red[600]!,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        onTap: () {},
      ),
    );
  }

  Widget statisticsItem(BuildContext context, IconData icon, String count, {Color? iconColor}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: iconColor ?? Theme.of(context).primaryColor,
        ),
        const SizedBox(width: 5),
        Text(
          count,
          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
