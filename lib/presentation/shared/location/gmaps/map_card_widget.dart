import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class MapCardWidget extends StatelessWidget {
  final GMapsPlaceModel place;
  const MapCardWidget({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const cardRadius = WidgetConstants.kCradBorderRadius;
    const double cardHeight = 220;
    // final heroTag = UniqueKey().toString();
    final heroTag = place.id;

    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(cardRadius),
      color: theme.listTileTheme.tileColor,
      elevation: 4,
      child: InkWell(
        onTap: () {
          print(context.router.current.meta);
          context.router.push(GMapsDetailsRoute(id: place.id, heroTag: heroTag, place: place));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: cardHeight * 0.6,
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(cardRadius),
                    topRight: Radius.circular(cardRadius),
                  ),
                  child: CustomCachedImage(
                    imageUrl: place.thumbnail.url,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.name,
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.grey,
                          size: 15,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            place.residence!,
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.5,
                            ),
                            // style: TextStyle(
                            //   color: Colors.grey[700],
                            //   fontWeight: FontWeight.w400,
                            //   fontSize: 12.5,
                            // ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: place.rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding: EdgeInsets.zero,
                          itemSize: 18,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (double value) {},
                        ),
                        Container(width: 5),
                        Text(
                          '${place.rating} (${place.reviewsCount}) ${place.category}',
                          // style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                          style: theme.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
