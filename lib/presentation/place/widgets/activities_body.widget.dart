import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/place/widgets/activity_cards.widget.dart';
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
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => RestaurantsScreen(place)));
                    context.pushRoute(
                        RestaurantsRouter(children: [RestaurantsRoute(location: place)]));
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: PlaceActivitiyColorCard(
                  text: LocaleKeys.nearby_hotels.tr(),
                  color: Colors.blueAccent[400]!,
                  icon: Icons.hotel_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          PlaceActivityImageCard(
            text: "",
            icon: Icons.navigation_rounded,
            image: CustomCachedImage(
              imageUrl: GMapsUtils.getMapTileWithPinURL(place.coordinates!),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
