/* import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/gallery/gallery.screen.dart';
import 'package:xplore_bg_v2/presentation/place/place.screen.dart';

void nextScreenHero(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        // final curvedAnimation = CurvedAnimation(
        //   parent: animation,
        //   curve: const Interval(0, 0.7),
        // );

        return FadeTransition(
          // opacity: curvedAnimation,
          opacity: animation,
          child: page,
        );
      },
    ),
  );
}

void placeScreenHero(BuildContext context, PlaceModel placeModel) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        // final curvedAnimation = CurvedAnimation(
        //   parent: animation,
        //   curve: const Interval(0, 0.7),
        // );

        return FadeTransition(
          // opacity: curvedAnimation,
          opacity: animation,
          child: PlaceDetailsScreen(
            place: placeModel,
            transitionAnimation: animation,
            heroTag: "",
          ),
        );
      },
    ),
  );
}

void openPhotoViewGallery(BuildContext context, int index, GalleryModel gallery) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => GalleryScreen(
        gallery: gallery,
        index: index,
      ),
    ),
  );
}
 */