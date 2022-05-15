import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/infrastructure/providers/location.provider.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/location/place.model.dart';

class NearbyCardWidget extends ConsumerWidget {
  final PlaceModel place;
  final double elevation;
  final bool useGeolocator;
  const NearbyCardWidget({
    Key? key,
    required this.place,
    this.elevation = 4,
    this.useGeolocator = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    const radius = WidgetConstants.kCradBorderRadius;
    final currentLocation =
        ref.watch(locationProvider.select((value) => useGeolocator ? value : null));

    final heroTag = UniqueKey().toString();

    return LayoutBuilder(builder: (context, constraints) {
      return Material(
        borderRadius: BorderRadius.circular(radius),
        elevation: elevation,
        color: theme.listTileTheme.tileColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: () {
            context.pushRoute(
                LocationRouter(children: [LocationRoute(place: place, heroTag: heroTag)]));
          },
          child: Container(
            width: constraints.maxHeight * 0.8, // 4/3 ratio
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
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
                              if (useGeolocator)
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 32,
                                    alignment: Alignment.center,
                                    width: constraints.maxWidth - radius * 2,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900]?.withOpacity(0.9),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(radius),
                                        bottomRight: Radius.circular(radius),
                                      ),
                                    ),
                                    child: currentLocation?.when(
                                      data: (location) {
                                        final distance = Geolocator.distanceBetween(
                                                location.latitude,
                                                location.longitude,
                                                place.coordinates!.latitude,
                                                place.coordinates!.longitude)
                                            .toInt();
                                        return Text(
                                          "${distance.toString()} m",
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.white),
                                        );
                                      },
                                      loading: () => const CircularProgressIndicator(),
                                      error: (error, stk) => null,
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
