import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/place.model.dart';

class NearbyCardWidget extends StatelessWidget {
  final PlaceModel place;
  final double elevation;
  const NearbyCardWidget({
    Key? key,
    required this.place,
    this.elevation = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const radius = WidgetConstants.kCradBorderRadius;
    final currentLocation = LatLng(41.84126118480892, 23.48859392410678);
    final int distFromMe = const Distance().distance(currentLocation, place.coordinates!).toInt();

    final heroTag = "nearby@${place.id}";

    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        borderRadius: BorderRadius.circular(radius),
        elevation: elevation,
        color: theme.listTileTheme.tileColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            context.pushRoute(LocationRouter(children: [LocationRoute(place: place)]));
          },
          child: Container(
            width: constraints.maxHeight * 0.8, // 4/3 ratio
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              // color: theme.listTileTheme.tileColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Material(
                      borderRadius: BorderRadius.circular(radius),
                      elevation: elevation,
                      child: Hero(
                        tag: heroTag,
                        child: Container(
                          width: constraints.maxWidth,
                          height: constraints.maxWidth * 0.95,
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
                                // alignment: Alignment.bottomCenter,
                                // alignment: Alignment.topCenter,
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 32,
                                  alignment: Alignment.center,
                                  width: constraints.maxWidth - radius * 2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[900]?.withOpacity(0.9),
                                    // borderRadius: const BorderRadius.only(
                                    //   topLeft: Radius.circular(radius),
                                    //   topRight: Radius.circular(radius),
                                    // ),
                                    // borderRadius: const BorderRadius.only(
                                    //   bottomLeft: Radius.circular(radius),
                                    //   bottomRight: Radius.circular(radius),
                                    // ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(radius),
                                      bottomRight: Radius.circular(radius),
                                    ),
                                  ),
                                  child: Text(
                                    "${distFromMe.toString()} m",
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
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
                  child: Text(
                    place.name.toString(),
                    maxLines: 2,
                    style: theme.textTheme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
