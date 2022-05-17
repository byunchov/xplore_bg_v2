import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/url_launcher.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/places/details/activity_cards.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PlaceActivitiesBody extends StatelessWidget {
  final PlaceModel place;
  const PlaceActivitiesBody({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PlaceActivitiyColorCard(
                  text: LocaleKeys.nearby_rest.tr(),
                  color: Colors.orange[300]!,
                  icon: Icons.restaurant_menu,
                  callback: () {
                    context.pushRoute(
                        RestaurantsRouter(children: [RestaurantsRoute(locId: place.id)]));
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PlaceActivitiyColorCard(
                  text: LocaleKeys.nearby_hotels.tr(),
                  color: Colors.blueAccent[400]!,
                  icon: Icons.hotel_rounded,
                  callback: () {
                    context.pushRoute(LodgingRouter(children: [LodgingRoute(locId: place.id)]));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          PlaceActivityImageCard(
            text: "",
            icon: Icons.navigation_rounded,
            image: CustomCachedImage(
              imageUrl: GMapsUtils.getMapTileWithPinURL(
                place.coordinates!,
                lang: context.locale.languageCode,
              ),
              fit: BoxFit.cover,
            ),
            callback: () async {
              final launched = await UrlLauncherUtils.launchCoordinates(
                  place.coordinates!.latitude, place.coordinates!.longitude, place.name);

              if (!launched) {
                SnackbarUtils.showSnackBar(context, message: "Error launching target!");
              }
            },
          ),
        ],
      ),
    );
  }
}
