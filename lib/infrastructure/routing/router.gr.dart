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
import 'package:firebase_auth/firebase_auth.dart' as _i15;
import 'package:flutter/material.dart' as _i14;
import 'package:xplore_bg_v2/models/models.dart' as _i16;
import 'package:xplore_bg_v2/presentation/bookmarks/bookmarked.screen.dart'
    as _i7;
import 'package:xplore_bg_v2/presentation/bookmarks/liked.screen.dart' as _i6;
import 'package:xplore_bg_v2/presentation/category/category.screen.dart' as _i4;
import 'package:xplore_bg_v2/presentation/category/category_filters.screen.dart'
    as _i5;
import 'package:xplore_bg_v2/presentation/gallery/gallery.screen.dart' as _i9;
import 'package:xplore_bg_v2/presentation/launcher/auth_checker.screen.dart'
    as _i1;
import 'package:xplore_bg_v2/presentation/place/place.screen.dart' as _i8;
import 'package:xplore_bg_v2/presentation/restaurants/lodging.screen.dart'
    as _i12;
import 'package:xplore_bg_v2/presentation/restaurants/lodging_deatils.screen.dart'
    as _i13;
import 'package:xplore_bg_v2/presentation/restaurants/restaurant_deatils.screen.dart'
    as _i11;
import 'package:xplore_bg_v2/presentation/restaurants/restaurants.screen.dart'
    as _i10;
import 'package:xplore_bg_v2/presentation/screens.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    AuthCheckerRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AuthCheckerScreen());
    },
    HomeRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.HomeScreen());
    },
    SigninRoute.name: (routeData) {
      final args = routeData.argsAs<SigninRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.SignInScreen(
              key: args.key, onSignInCallback: args.onSignInCallback));
    },
    SearchRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.SearchScreen());
    },
    LocationRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    ExploreRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.ExploreScreen());
    },
    LandmarksRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    NotedLocationsRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.BookmarksScreen());
    },
    UserProfileRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.UserProfileScreen());
    },
    LandmarkCategoriesRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LandmarkCategoriesScreen());
    },
    CategoryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CategoryRouteArgs>(
          orElse: () => CategoryRouteArgs(tag: pathParams.getString('tag')));
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i4.CategoryScreen(
              key: args.key, tag: args.tag, category: args.category));
    },
    CategoryFilterRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryFilterRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i5.CategoryFilterScreen(
              key: args.key, tag: args.tag, name: args.name));
    },
    LikedLocationsRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.LikedLocationsScreen());
    },
    BookmarkedLocationsRoute.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i7.BookmarkedLocationsScreen());
    },
    LocationRoute.name: (routeData) {
      final args = routeData.argsAs<LocationRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.PlaceDetailsScreen(
              key: args.key,
              place: args.place,
              heroTag: args.heroTag,
              transitionAnimation: args.transitionAnimation));
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
              _i9.GalleryScreen(key: args.key, id: args.id, index: args.index));
    },
    LodgingRouter.name: (routeData) {
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.EmptyRouterPage());
    },
    RestaurantsRoute.name: (routeData) {
      final args = routeData.argsAs<RestaurantsRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i10.RestaurantsScreen(args.location, key: args.key));
    },
    RestaurantDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RestaurantDetailsRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i11.RestaurantDetailsScreen(
              key: args.key,
              id: args.id,
              restaurant: args.restaurant,
              heroTag: args.heroTag));
    },
    LodgingRoute.name: (routeData) {
      final args = routeData.argsAs<LodgingRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i12.LodgingScreen(args.locId, key: args.key));
    },
    LodgingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<LodgingDetailsRouteArgs>();
      return _i3.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i13.LodgingDetailsScreen(
              key: args.key,
              id: args.id,
              lodging: args.lodging,
              heroTag: args.heroTag));
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
        _i3.RouteConfig(LocationRouter.name, path: '/location', children: [
          _i3.RouteConfig(LocationRoute.name,
              path: '', parent: LocationRouter.name),
          _i3.RouteConfig(RestaurantsRouter.name,
              path: 'restaurants',
              parent: LocationRouter.name,
              children: [
                _i3.RouteConfig(RestaurantsRoute.name,
                    path: '', parent: RestaurantsRouter.name),
                _i3.RouteConfig(RestaurantDetailsRoute.name,
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
                _i3.RouteConfig(LodgingDetailsRoute.name,
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
/// [_i2.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.SignInScreen]
class SigninRoute extends _i3.PageRouteInfo<SigninRouteArgs> {
  SigninRoute(
      {_i14.Key? key, required void Function(_i15.User) onSignInCallback})
      : super(SigninRoute.name,
            path: '/signin',
            args:
                SigninRouteArgs(key: key, onSignInCallback: onSignInCallback));

  static const String name = 'SigninRoute';
}

class SigninRouteArgs {
  const SigninRouteArgs({this.key, required this.onSignInCallback});

  final _i14.Key? key;

  final void Function(_i15.User) onSignInCallback;

  @override
  String toString() {
    return 'SigninRouteArgs{key: $key, onSignInCallback: $onSignInCallback}';
  }
}

/// generated route for
/// [_i2.SearchScreen]
class SearchRoute extends _i3.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '/search');

  static const String name = 'SearchRoute';
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
/// [_i2.ExploreScreen]
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
/// [_i2.BookmarksScreen]
class NotedLocationsRouter extends _i3.PageRouteInfo<void> {
  const NotedLocationsRouter({List<_i3.PageRouteInfo>? children})
      : super(NotedLocationsRouter.name,
            path: 'bookmarks', initialChildren: children);

  static const String name = 'NotedLocationsRouter';
}

/// generated route for
/// [_i2.UserProfileScreen]
class UserProfileRoute extends _i3.PageRouteInfo<void> {
  const UserProfileRoute() : super(UserProfileRoute.name, path: 'user');

  static const String name = 'UserProfileRoute';
}

/// generated route for
/// [_i2.LandmarkCategoriesScreen]
class LandmarkCategoriesRoute extends _i3.PageRouteInfo<void> {
  const LandmarkCategoriesRoute()
      : super(LandmarkCategoriesRoute.name, path: '');

  static const String name = 'LandmarkCategoriesRoute';
}

/// generated route for
/// [_i4.CategoryScreen]
class CategoryRoute extends _i3.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute(
      {_i14.Key? key, required String tag, _i16.CategoryModel? category})
      : super(CategoryRoute.name,
            path: ':tag',
            args: CategoryRouteArgs(key: key, tag: tag, category: category),
            rawPathParams: {'tag': tag});

  static const String name = 'CategoryRoute';
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.key, required this.tag, this.category});

  final _i14.Key? key;

  final String tag;

  final _i16.CategoryModel? category;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, tag: $tag, category: $category}';
  }
}

/// generated route for
/// [_i5.CategoryFilterScreen]
class CategoryFilterRoute extends _i3.PageRouteInfo<CategoryFilterRouteArgs> {
  CategoryFilterRoute(
      {_i14.Key? key, required String tag, required String name})
      : super(CategoryFilterRoute.name,
            path: ':tag/filters',
            args: CategoryFilterRouteArgs(key: key, tag: tag, name: name));

  static const String name = 'CategoryFilterRoute';
}

class CategoryFilterRouteArgs {
  const CategoryFilterRouteArgs(
      {this.key, required this.tag, required this.name});

  final _i14.Key? key;

  final String tag;

  final String name;

  @override
  String toString() {
    return 'CategoryFilterRouteArgs{key: $key, tag: $tag, name: $name}';
  }
}

/// generated route for
/// [_i6.LikedLocationsScreen]
class LikedLocationsRoute extends _i3.PageRouteInfo<void> {
  const LikedLocationsRoute() : super(LikedLocationsRoute.name, path: 'likes');

  static const String name = 'LikedLocationsRoute';
}

/// generated route for
/// [_i7.BookmarkedLocationsScreen]
class BookmarkedLocationsRoute extends _i3.PageRouteInfo<void> {
  const BookmarkedLocationsRoute()
      : super(BookmarkedLocationsRoute.name, path: 'bookmarks');

  static const String name = 'BookmarkedLocationsRoute';
}

/// generated route for
/// [_i8.PlaceDetailsScreen]
class LocationRoute extends _i3.PageRouteInfo<LocationRouteArgs> {
  LocationRoute(
      {_i14.Key? key,
      required _i16.PlaceModel place,
      required String heroTag,
      _i14.Animation<double>? transitionAnimation})
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

  final _i14.Key? key;

  final _i16.PlaceModel place;

  final String heroTag;

  final _i14.Animation<double>? transitionAnimation;

  @override
  String toString() {
    return 'LocationRouteArgs{key: $key, place: $place, heroTag: $heroTag, transitionAnimation: $transitionAnimation}';
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
/// [_i9.GalleryScreen]
class GalleryRoute extends _i3.PageRouteInfo<GalleryRouteArgs> {
  GalleryRoute({_i14.Key? key, required String id, int index = 0})
      : super(GalleryRoute.name,
            path: 'gallery/:index',
            args: GalleryRouteArgs(key: key, id: id, index: index),
            rawPathParams: {'id': id, 'index': index});

  static const String name = 'GalleryRoute';
}

class GalleryRouteArgs {
  const GalleryRouteArgs({this.key, required this.id, this.index = 0});

  final _i14.Key? key;

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
/// [_i10.RestaurantsScreen]
class RestaurantsRoute extends _i3.PageRouteInfo<RestaurantsRouteArgs> {
  RestaurantsRoute({required _i16.LocationModel location, _i14.Key? key})
      : super(RestaurantsRoute.name,
            path: '', args: RestaurantsRouteArgs(location: location, key: key));

  static const String name = 'RestaurantsRoute';
}

class RestaurantsRouteArgs {
  const RestaurantsRouteArgs({required this.location, this.key});

  final _i16.LocationModel location;

  final _i14.Key? key;

  @override
  String toString() {
    return 'RestaurantsRouteArgs{location: $location, key: $key}';
  }
}

/// generated route for
/// [_i11.RestaurantDetailsScreen]
class RestaurantDetailsRoute
    extends _i3.PageRouteInfo<RestaurantDetailsRouteArgs> {
  RestaurantDetailsRoute(
      {_i14.Key? key,
      required String id,
      required _i16.RestaurantModel restaurant,
      required String heroTag})
      : super(RestaurantDetailsRoute.name,
            path: ':id',
            args: RestaurantDetailsRouteArgs(
                key: key, id: id, restaurant: restaurant, heroTag: heroTag),
            rawPathParams: {'id': id});

  static const String name = 'RestaurantDetailsRoute';
}

class RestaurantDetailsRouteArgs {
  const RestaurantDetailsRouteArgs(
      {this.key,
      required this.id,
      required this.restaurant,
      required this.heroTag});

  final _i14.Key? key;

  final String id;

  final _i16.RestaurantModel restaurant;

  final String heroTag;

  @override
  String toString() {
    return 'RestaurantDetailsRouteArgs{key: $key, id: $id, restaurant: $restaurant, heroTag: $heroTag}';
  }
}

/// generated route for
/// [_i12.LodgingScreen]
class LodgingRoute extends _i3.PageRouteInfo<LodgingRouteArgs> {
  LodgingRoute({required String locId, _i14.Key? key})
      : super(LodgingRoute.name,
            path: '', args: LodgingRouteArgs(locId: locId, key: key));

  static const String name = 'LodgingRoute';
}

class LodgingRouteArgs {
  const LodgingRouteArgs({required this.locId, this.key});

  final String locId;

  final _i14.Key? key;

  @override
  String toString() {
    return 'LodgingRouteArgs{locId: $locId, key: $key}';
  }
}

/// generated route for
/// [_i13.LodgingDetailsScreen]
class LodgingDetailsRoute extends _i3.PageRouteInfo<LodgingDetailsRouteArgs> {
  LodgingDetailsRoute(
      {_i14.Key? key,
      required String id,
      required _i16.GMapsPlaceModel lodging,
      required String heroTag})
      : super(LodgingDetailsRoute.name,
            path: ':id',
            args: LodgingDetailsRouteArgs(
                key: key, id: id, lodging: lodging, heroTag: heroTag),
            rawPathParams: {'id': id});

  static const String name = 'LodgingDetailsRoute';
}

class LodgingDetailsRouteArgs {
  const LodgingDetailsRouteArgs(
      {this.key,
      required this.id,
      required this.lodging,
      required this.heroTag});

  final _i14.Key? key;

  final String id;

  final _i16.GMapsPlaceModel lodging;

  final String heroTag;

  @override
  String toString() {
    return 'LodgingDetailsRouteArgs{key: $key, id: $id, lodging: $lodging, heroTag: $heroTag}';
  }
}
