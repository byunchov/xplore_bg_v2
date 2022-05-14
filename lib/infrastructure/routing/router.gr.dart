// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i5;
import 'package:xplore_bg_v2/models/location/place.model.dart' as _i7;
import 'package:xplore_bg_v2/models/models.dart' as _i6;
import 'package:xplore_bg_v2/presentation/explore/show_more_nearby.screen.dart'
    as _i2;
import 'package:xplore_bg_v2/presentation/location/reviews/add_review.screen.dart'
    as _i4;
import 'package:xplore_bg_v2/presentation/screens.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    AuthCheckerRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AuthCheckerScreen());
    },
    HomeRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    SigninRoute.name: (routeData) {
      final args = routeData.argsAs<SigninRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.SignInScreen(
              key: args.key, onSignInCallback: args.onSignInCallback));
    },
    SearchRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.SearchScreen());
    },
    ChooseLanguageRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ChooseLanguageScreen());
    },
    ShowMoreNearbyRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.ShowMoreNearbyScreen());
    },
    LocationRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    ExploreRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ExploreScreen());
    },
    LandmarksRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    NotedLocationsRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.NotedScreen());
    },
    UserProfileRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.UserProfileScreen());
    },
    LandmarkCategoriesRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LandmarkCategoriesScreen());
    },
    CategoryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CategoryRouteArgs>(
          orElse: () => CategoryRouteArgs(tag: pathParams.getString('tag')));
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.CategoryScreen(
              key: args.key, tag: args.tag, category: args.category));
    },
    CategoryFilterRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryFilterRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.CategoryFilterScreen(
              key: args.key, tag: args.tag, name: args.name));
    },
    LikedLocationsRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LikedLocationsScreen());
    },
    BookmarkedLocationsRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.BookmarkedLocationsScreen());
    },
    LocationRoute.name: (routeData) {
      final args = routeData.argsAs<LocationRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.PlaceDetailsScreen(
              key: args.key,
              place: args.place,
              heroTag: args.heroTag,
              transitionAnimation: args.transitionAnimation));
    },
    PlaceReviewsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PlaceReviewsRouteArgs>(
          orElse: () =>
              PlaceReviewsRouteArgs(locId: pathParams.getString('id')));
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.PlaceReviewsScreen(key: args.key, locId: args.locId));
    },
    AddReviewRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<AddReviewRouteArgs>(
          orElse: () => AddReviewRouteArgs(locId: pathParams.getString('id')));
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i4.AddReviewScreen(key: args.key, locId: args.locId));
    },
    RestaurantsRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    GalleryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GalleryRouteArgs>(
          orElse: () => GalleryRouteArgs(
              id: pathParams.getString('id'),
              index: pathParams.getInt('index', 0)));
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child:
              _i1.GalleryScreen(key: args.key, id: args.id, index: args.index));
    },
    LodgingRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    RestaurantsRoute.name: (routeData) {
      final args = routeData.argsAs<RestaurantsRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.RestaurantsScreen(args.locId, key: args.key));
    },
    GMapsDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<GMapsDetailsRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.GMapsDetailsScreen(
              key: args.key,
              id: args.id,
              place: args.place,
              heroTag: args.heroTag));
    },
    LodgingRoute.name: (routeData) {
      final args = routeData.argsAs<LodgingRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.LodgingScreen(args.locId, key: args.key));
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i3.RouteConfig(AuthCheckerRoute.name, path: '/auth-checker-screen'),
        _i3.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i3.RouteConfig(ExploreRoute.name,
              path: 'explore', parent: HomeRoute.name),
          _i3.RouteConfig(LandmarksRouter.name,
              path: 'categories',
              parent: HomeRoute.name,
              children: [
                _i3.RouteConfig(LandmarkCategoriesRoute.name,
                    path: '', parent: LandmarksRouter.name),
                _i3.RouteConfig(CategoryRoute.name,
                    path: ':tag', parent: LandmarksRouter.name),
                _i3.RouteConfig(CategoryFilterRoute.name,
                    path: ':tag/filters', parent: LandmarksRouter.name)
              ]),
          _i3.RouteConfig(NotedLocationsRouter.name,
              path: 'bookmarks',
              parent: HomeRoute.name,
              children: [
                _i3.RouteConfig(LikedLocationsRoute.name,
                    path: 'likes', parent: NotedLocationsRouter.name),
                _i3.RouteConfig(BookmarkedLocationsRoute.name,
                    path: 'bookmarks', parent: NotedLocationsRouter.name)
              ]),
          _i3.RouteConfig(UserProfileRoute.name,
              path: 'user', parent: HomeRoute.name)
        ]),
        _i3.RouteConfig(SigninRoute.name, path: '/signin'),
        _i3.RouteConfig(SearchRoute.name, path: '/search'),
        _i3.RouteConfig(ChooseLanguageRoute.name, path: '/language'),
        _i3.RouteConfig(ShowMoreNearbyRoute.name, path: '/nearby'),
        _i3.RouteConfig(LocationRouter.name, path: '/location', children: [
          _i3.RouteConfig(LocationRoute.name,
              path: '', parent: LocationRouter.name),
          _i3.RouteConfig(PlaceReviewsRoute.name,
              path: 'reviews/:id', parent: LocationRouter.name),
          _i3.RouteConfig(AddReviewRoute.name,
              path: 'review/:id', parent: LocationRouter.name),
          _i3.RouteConfig(RestaurantsRouter.name,
              path: 'restaurants',
              parent: LocationRouter.name,
              children: [
                _i3.RouteConfig(RestaurantsRoute.name,
                    path: '', parent: RestaurantsRouter.name),
                _i3.RouteConfig(GMapsDetailsRoute.name,
                    path: ':id', parent: RestaurantsRouter.name)
              ]),
          _i3.RouteConfig(GalleryRoute.name,
              path: 'gallery/:index', parent: LocationRouter.name),
          _i3.RouteConfig(LodgingRouter.name,
              path: 'lodging',
              parent: LocationRouter.name,
              children: [
                _i3.RouteConfig(LodgingRoute.name,
                    path: '', parent: LodgingRouter.name),
                _i3.RouteConfig(GMapsDetailsRoute.name,
                    path: ':id', parent: LodgingRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.AuthCheckerScreen]
class AuthCheckerRoute extends _i3.PageRouteInfo<void> {
  const AuthCheckerRoute()
      : super(AuthCheckerRoute.name, path: '/auth-checker-screen');

  static const String name = 'AuthCheckerRoute';
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.SignInScreen]
class SigninRoute extends _i3.PageRouteInfo<SigninRouteArgs> {
  SigninRoute(
      {_i5.Key? key, required void Function(_i6.UserModel) onSignInCallback})
      : super(SigninRoute.name,
            path: '/signin',
            args:
                SigninRouteArgs(key: key, onSignInCallback: onSignInCallback));

  static const String name = 'SigninRoute';
}

class SigninRouteArgs {
  const SigninRouteArgs({this.key, required this.onSignInCallback});

  final _i5.Key? key;

  final void Function(_i6.UserModel) onSignInCallback;

  @override
  String toString() {
    return 'SigninRouteArgs{key: $key, onSignInCallback: $onSignInCallback}';
  }
}

/// generated route for
/// [_i1.SearchScreen]
class SearchRoute extends _i3.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '/search');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i1.ChooseLanguageScreen]
class ChooseLanguageRoute extends _i3.PageRouteInfo<void> {
  const ChooseLanguageRoute()
      : super(ChooseLanguageRoute.name, path: '/language');

  static const String name = 'ChooseLanguageRoute';
}

/// generated route for
/// [_i2.ShowMoreNearbyScreen]
class ShowMoreNearbyRoute extends _i3.PageRouteInfo<void> {
  const ShowMoreNearbyRoute()
      : super(ShowMoreNearbyRoute.name, path: '/nearby');

  static const String name = 'ShowMoreNearbyRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class LocationRouter extends _i3.PageRouteInfo<void> {
  const LocationRouter({List<_i3.PageRouteInfo>? children})
      : super(LocationRouter.name,
            path: '/location', initialChildren: children);

  static const String name = 'LocationRouter';
}

/// generated route for
/// [_i1.ExploreScreen]
class ExploreRoute extends _i3.PageRouteInfo<void> {
  const ExploreRoute() : super(ExploreRoute.name, path: 'explore');

  static const String name = 'ExploreRoute';
}

/// generated route for
/// [_i3.EmptyRouterPage]
class LandmarksRouter extends _i3.PageRouteInfo<void> {
  const LandmarksRouter({List<_i3.PageRouteInfo>? children})
      : super(LandmarksRouter.name,
            path: 'categories', initialChildren: children);

  static const String name = 'LandmarksRouter';
}

/// generated route for
/// [_i1.NotedScreen]
class NotedLocationsRouter extends _i3.PageRouteInfo<void> {
  const NotedLocationsRouter({List<_i3.PageRouteInfo>? children})
      : super(NotedLocationsRouter.name,
            path: 'bookmarks', initialChildren: children);

  static const String name = 'NotedLocationsRouter';
}

/// generated route for
/// [_i1.UserProfileScreen]
class UserProfileRoute extends _i3.PageRouteInfo<void> {
  const UserProfileRoute() : super(UserProfileRoute.name, path: 'user');

  static const String name = 'UserProfileRoute';
}

/// generated route for
/// [_i1.LandmarkCategoriesScreen]
class LandmarkCategoriesRoute extends _i3.PageRouteInfo<void> {
  const LandmarkCategoriesRoute()
      : super(LandmarkCategoriesRoute.name, path: '');

  static const String name = 'LandmarkCategoriesRoute';
}

/// generated route for
/// [_i1.CategoryScreen]
class CategoryRoute extends _i3.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute(
      {_i5.Key? key, required String tag, _i6.CategoryModel? category})
      : super(CategoryRoute.name,
            path: ':tag',
            args: CategoryRouteArgs(key: key, tag: tag, category: category),
            rawPathParams: {'tag': tag});

  static const String name = 'CategoryRoute';
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.key, required this.tag, this.category});

  final _i5.Key? key;

  final String tag;

  final _i6.CategoryModel? category;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, tag: $tag, category: $category}';
  }
}

/// generated route for
/// [_i1.CategoryFilterScreen]
class CategoryFilterRoute extends _i3.PageRouteInfo<CategoryFilterRouteArgs> {
  CategoryFilterRoute({_i5.Key? key, required String tag, required String name})
      : super(CategoryFilterRoute.name,
            path: ':tag/filters',
            args: CategoryFilterRouteArgs(key: key, tag: tag, name: name));

  static const String name = 'CategoryFilterRoute';
}

class CategoryFilterRouteArgs {
  const CategoryFilterRouteArgs(
      {this.key, required this.tag, required this.name});

  final _i5.Key? key;

  final String tag;

  final String name;

  @override
  String toString() {
    return 'CategoryFilterRouteArgs{key: $key, tag: $tag, name: $name}';
  }
}

/// generated route for
/// [_i1.LikedLocationsScreen]
class LikedLocationsRoute extends _i3.PageRouteInfo<void> {
  const LikedLocationsRoute() : super(LikedLocationsRoute.name, path: 'likes');

  static const String name = 'LikedLocationsRoute';
}

/// generated route for
/// [_i1.BookmarkedLocationsScreen]
class BookmarkedLocationsRoute extends _i3.PageRouteInfo<void> {
  const BookmarkedLocationsRoute()
      : super(BookmarkedLocationsRoute.name, path: 'bookmarks');

  static const String name = 'BookmarkedLocationsRoute';
}

/// generated route for
/// [_i1.PlaceDetailsScreen]
class LocationRoute extends _i3.PageRouteInfo<LocationRouteArgs> {
  LocationRoute(
      {_i5.Key? key,
      required _i7.PlaceModel place,
      required String heroTag,
      _i5.Animation<double>? transitionAnimation})
      : super(LocationRoute.name,
            path: '',
            args: LocationRouteArgs(
                key: key,
                place: place,
                heroTag: heroTag,
                transitionAnimation: transitionAnimation));

  static const String name = 'LocationRoute';
}

class LocationRouteArgs {
  const LocationRouteArgs(
      {this.key,
      required this.place,
      required this.heroTag,
      this.transitionAnimation});

  final _i5.Key? key;

  final _i7.PlaceModel place;

  final String heroTag;

  final _i5.Animation<double>? transitionAnimation;

  @override
  String toString() {
    return 'LocationRouteArgs{key: $key, place: $place, heroTag: $heroTag, transitionAnimation: $transitionAnimation}';
  }
}

/// generated route for
/// [_i1.PlaceReviewsScreen]
class PlaceReviewsRoute extends _i3.PageRouteInfo<PlaceReviewsRouteArgs> {
  PlaceReviewsRoute({_i5.Key? key, required String locId})
      : super(PlaceReviewsRoute.name,
            path: 'reviews/:id',
            args: PlaceReviewsRouteArgs(key: key, locId: locId),
            rawPathParams: {'id': locId});

  static const String name = 'PlaceReviewsRoute';
}

class PlaceReviewsRouteArgs {
  const PlaceReviewsRouteArgs({this.key, required this.locId});

  final _i5.Key? key;

  final String locId;

  @override
  String toString() {
    return 'PlaceReviewsRouteArgs{key: $key, locId: $locId}';
  }
}

/// generated route for
/// [_i4.AddReviewScreen]
class AddReviewRoute extends _i3.PageRouteInfo<AddReviewRouteArgs> {
  AddReviewRoute({_i5.Key? key, required String locId})
      : super(AddReviewRoute.name,
            path: 'review/:id',
            args: AddReviewRouteArgs(key: key, locId: locId),
            rawPathParams: {'id': locId});

  static const String name = 'AddReviewRoute';
}

class AddReviewRouteArgs {
  const AddReviewRouteArgs({this.key, required this.locId});

  final _i5.Key? key;

  final String locId;

  @override
  String toString() {
    return 'AddReviewRouteArgs{key: $key, locId: $locId}';
  }
}

/// generated route for
/// [_i3.EmptyRouterPage]
class RestaurantsRouter extends _i3.PageRouteInfo<void> {
  const RestaurantsRouter({List<_i3.PageRouteInfo>? children})
      : super(RestaurantsRouter.name,
            path: 'restaurants', initialChildren: children);

  static const String name = 'RestaurantsRouter';
}

/// generated route for
/// [_i1.GalleryScreen]
class GalleryRoute extends _i3.PageRouteInfo<GalleryRouteArgs> {
  GalleryRoute({_i5.Key? key, required String id, int index = 0})
      : super(GalleryRoute.name,
            path: 'gallery/:index',
            args: GalleryRouteArgs(key: key, id: id, index: index),
            rawPathParams: {'id': id, 'index': index});

  static const String name = 'GalleryRoute';
}

class GalleryRouteArgs {
  const GalleryRouteArgs({this.key, required this.id, this.index = 0});

  final _i5.Key? key;

  final String id;

  final int index;

  @override
  String toString() {
    return 'GalleryRouteArgs{key: $key, id: $id, index: $index}';
  }
}

/// generated route for
/// [_i3.EmptyRouterPage]
class LodgingRouter extends _i3.PageRouteInfo<void> {
  const LodgingRouter({List<_i3.PageRouteInfo>? children})
      : super(LodgingRouter.name, path: 'lodging', initialChildren: children);

  static const String name = 'LodgingRouter';
}

/// generated route for
/// [_i1.RestaurantsScreen]
class RestaurantsRoute extends _i3.PageRouteInfo<RestaurantsRouteArgs> {
  RestaurantsRoute({required String locId, _i5.Key? key})
      : super(RestaurantsRoute.name,
            path: '', args: RestaurantsRouteArgs(locId: locId, key: key));

  static const String name = 'RestaurantsRoute';
}

class RestaurantsRouteArgs {
  const RestaurantsRouteArgs({required this.locId, this.key});

  final String locId;

  final _i5.Key? key;

  @override
  String toString() {
    return 'RestaurantsRouteArgs{locId: $locId, key: $key}';
  }
}

/// generated route for
/// [_i1.GMapsDetailsScreen]
class GMapsDetailsRoute extends _i3.PageRouteInfo<GMapsDetailsRouteArgs> {
  GMapsDetailsRoute(
      {_i5.Key? key,
      required String id,
      required _i6.GMapsPlaceModel place,
      required String heroTag})
      : super(GMapsDetailsRoute.name,
            path: ':id',
            args: GMapsDetailsRouteArgs(
                key: key, id: id, place: place, heroTag: heroTag),
            rawPathParams: {'id': id});

  static const String name = 'GMapsDetailsRoute';
}

class GMapsDetailsRouteArgs {
  const GMapsDetailsRouteArgs(
      {this.key, required this.id, required this.place, required this.heroTag});

  final _i5.Key? key;

  final String id;

  final _i6.GMapsPlaceModel place;

  final String heroTag;

  @override
  String toString() {
    return 'GMapsDetailsRouteArgs{key: $key, id: $id, place: $place, heroTag: $heroTag}';
  }
}

/// generated route for
/// [_i1.LodgingScreen]
class LodgingRoute extends _i3.PageRouteInfo<LodgingRouteArgs> {
  LodgingRoute({required String locId, _i5.Key? key})
      : super(LodgingRoute.name,
            path: '', args: LodgingRouteArgs(locId: locId, key: key));

  static const String name = 'LodgingRoute';
}

class LodgingRouteArgs {
  const LodgingRouteArgs({required this.locId, this.key});

  final String locId;

  final _i5.Key? key;

  @override
  String toString() {
    return 'LodgingRouteArgs{locId: $locId, key: $key}';
  }
}
