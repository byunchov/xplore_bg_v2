// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:flutter/material.dart' as _i3;
import 'package:xplore_bg_v2/models/category.model.dart' as _i5;
import 'package:xplore_bg_v2/models/models.dart' as _i6;
import 'package:xplore_bg_v2/presentation/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    AuthCheckerRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AuthCheckerScreen());
    },
    HomeRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    SigninRoute.name: (routeData) {
      final args = routeData.argsAs<SigninRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.SignInScreen(
              key: args.key, onSignInCallback: args.onSignInCallback));
    },
    SearchRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.SearchScreen());
    },
    LocationRouter.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    ExploreRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ExploreScreen());
    },
    LandmarksRouter.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    NotedLocationsRouter.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.BookmarksScreen());
    },
    UserProfileRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.UserProfileScreen());
    },
    LandmarkCategoriesRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LandmarkCategoriesScreen());
    },
    CategoryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CategoryRouteArgs>(
          orElse: () => CategoryRouteArgs(tag: pathParams.getString('tag')));
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.CategoryScreen(
              key: args.key, tag: args.tag, category: args.category));
    },
    CategoryFilterRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryFilterRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.CategoryFilterScreen(
              key: args.key, tag: args.tag, name: args.name));
    },
    LikedLocationsRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LikedLocationsScreen());
    },
    BookmarkedLocationsRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.BookmarkedLocationsScreen());
    },
    LocationRoute.name: (routeData) {
      final args = routeData.argsAs<LocationRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
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
          orElse: () => PlaceReviewsRouteArgs(id: pathParams.getString('id')));
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.PlaceReviewsScreen(key: args.key, id: args.id));
    },
    RestaurantsRouter.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    GalleryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<GalleryRouteArgs>(
          orElse: () => GalleryRouteArgs(
              id: pathParams.getString('id'),
              index: pathParams.getInt('index', 0)));
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child:
              _i1.GalleryScreen(key: args.key, id: args.id, index: args.index));
    },
    LodgingRouter.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    RestaurantsRoute.name: (routeData) {
      final args = routeData.argsAs<RestaurantsRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.RestaurantsScreen(args.locId, key: args.key));
    },
    GMapsDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<GMapsDetailsRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.GMapsDetailsScreen(
              key: args.key,
              id: args.id,
              place: args.place,
              heroTag: args.heroTag));
    },
    LodgingRoute.name: (routeData) {
      final args = routeData.argsAs<LodgingRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i1.LodgingScreen(args.locId, key: args.key));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig('/#redirect',
            path: '/', redirectTo: '/home', fullMatch: true),
        _i2.RouteConfig(AuthCheckerRoute.name, path: '/auth-checker-screen'),
        _i2.RouteConfig(HomeRoute.name, path: '/home', children: [
          _i2.RouteConfig(ExploreRoute.name,
              path: 'explore', parent: HomeRoute.name),
          _i2.RouteConfig(LandmarksRouter.name,
              path: 'categories',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(LandmarkCategoriesRoute.name,
                    path: '', parent: LandmarksRouter.name),
                _i2.RouteConfig(CategoryRoute.name,
                    path: ':tag', parent: LandmarksRouter.name),
                _i2.RouteConfig(CategoryFilterRoute.name,
                    path: ':tag/filters', parent: LandmarksRouter.name)
              ]),
          _i2.RouteConfig(NotedLocationsRouter.name,
              path: 'bookmarks',
              parent: HomeRoute.name,
              children: [
                _i2.RouteConfig(LikedLocationsRoute.name,
                    path: 'likes', parent: NotedLocationsRouter.name),
                _i2.RouteConfig(BookmarkedLocationsRoute.name,
                    path: 'bookmarks', parent: NotedLocationsRouter.name)
              ]),
          _i2.RouteConfig(UserProfileRoute.name,
              path: 'user', parent: HomeRoute.name)
        ]),
        _i2.RouteConfig(SigninRoute.name, path: '/signin'),
        _i2.RouteConfig(SearchRoute.name, path: '/search'),
        _i2.RouteConfig(LocationRouter.name, path: '/location', children: [
          _i2.RouteConfig(LocationRoute.name,
              path: '', parent: LocationRouter.name),
          _i2.RouteConfig(PlaceReviewsRoute.name,
              path: 'reviews/:id', parent: LocationRouter.name),
          _i2.RouteConfig(RestaurantsRouter.name,
              path: 'restaurants',
              parent: LocationRouter.name,
              children: [
                _i2.RouteConfig(RestaurantsRoute.name,
                    path: '', parent: RestaurantsRouter.name),
                _i2.RouteConfig(GMapsDetailsRoute.name,
                    path: ':id', parent: RestaurantsRouter.name)
              ]),
          _i2.RouteConfig(GalleryRoute.name,
              path: 'gallery/:index', parent: LocationRouter.name),
          _i2.RouteConfig(LodgingRouter.name,
              path: 'lodging',
              parent: LocationRouter.name,
              children: [
                _i2.RouteConfig(LodgingRoute.name,
                    path: '', parent: LodgingRouter.name),
                _i2.RouteConfig(GMapsDetailsRoute.name,
                    path: ':id', parent: LodgingRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.AuthCheckerScreen]
class AuthCheckerRoute extends _i2.PageRouteInfo<void> {
  const AuthCheckerRoute()
      : super(AuthCheckerRoute.name, path: '/auth-checker-screen');

  static const String name = 'AuthCheckerRoute';
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.SignInScreen]
class SigninRoute extends _i2.PageRouteInfo<SigninRouteArgs> {
  SigninRoute({_i3.Key? key, required void Function(_i4.User) onSignInCallback})
      : super(SigninRoute.name,
            path: '/signin',
            args:
                SigninRouteArgs(key: key, onSignInCallback: onSignInCallback));

  static const String name = 'SigninRoute';
}

class SigninRouteArgs {
  const SigninRouteArgs({this.key, required this.onSignInCallback});

  final _i3.Key? key;

  final void Function(_i4.User) onSignInCallback;

  @override
  String toString() {
    return 'SigninRouteArgs{key: $key, onSignInCallback: $onSignInCallback}';
  }
}

/// generated route for
/// [_i1.SearchScreen]
class SearchRoute extends _i2.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: '/search');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class LocationRouter extends _i2.PageRouteInfo<void> {
  const LocationRouter({List<_i2.PageRouteInfo>? children})
      : super(LocationRouter.name,
            path: '/location', initialChildren: children);

  static const String name = 'LocationRouter';
}

/// generated route for
/// [_i1.ExploreScreen]
class ExploreRoute extends _i2.PageRouteInfo<void> {
  const ExploreRoute() : super(ExploreRoute.name, path: 'explore');

  static const String name = 'ExploreRoute';
}

/// generated route for
/// [_i2.EmptyRouterPage]
class LandmarksRouter extends _i2.PageRouteInfo<void> {
  const LandmarksRouter({List<_i2.PageRouteInfo>? children})
      : super(LandmarksRouter.name,
            path: 'categories', initialChildren: children);

  static const String name = 'LandmarksRouter';
}

/// generated route for
/// [_i1.BookmarksScreen]
class NotedLocationsRouter extends _i2.PageRouteInfo<void> {
  const NotedLocationsRouter({List<_i2.PageRouteInfo>? children})
      : super(NotedLocationsRouter.name,
            path: 'bookmarks', initialChildren: children);

  static const String name = 'NotedLocationsRouter';
}

/// generated route for
/// [_i1.UserProfileScreen]
class UserProfileRoute extends _i2.PageRouteInfo<void> {
  const UserProfileRoute() : super(UserProfileRoute.name, path: 'user');

  static const String name = 'UserProfileRoute';
}

/// generated route for
/// [_i1.LandmarkCategoriesScreen]
class LandmarkCategoriesRoute extends _i2.PageRouteInfo<void> {
  const LandmarkCategoriesRoute()
      : super(LandmarkCategoriesRoute.name, path: '');

  static const String name = 'LandmarkCategoriesRoute';
}

/// generated route for
/// [_i1.CategoryScreen]
class CategoryRoute extends _i2.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute(
      {_i3.Key? key, required String tag, _i5.CategoryModel? category})
      : super(CategoryRoute.name,
            path: ':tag',
            args: CategoryRouteArgs(key: key, tag: tag, category: category),
            rawPathParams: {'tag': tag});

  static const String name = 'CategoryRoute';
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.key, required this.tag, this.category});

  final _i3.Key? key;

  final String tag;

  final _i5.CategoryModel? category;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, tag: $tag, category: $category}';
  }
}

/// generated route for
/// [_i1.CategoryFilterScreen]
class CategoryFilterRoute extends _i2.PageRouteInfo<CategoryFilterRouteArgs> {
  CategoryFilterRoute({_i3.Key? key, required String tag, required String name})
      : super(CategoryFilterRoute.name,
            path: ':tag/filters',
            args: CategoryFilterRouteArgs(key: key, tag: tag, name: name));

  static const String name = 'CategoryFilterRoute';
}

class CategoryFilterRouteArgs {
  const CategoryFilterRouteArgs(
      {this.key, required this.tag, required this.name});

  final _i3.Key? key;

  final String tag;

  final String name;

  @override
  String toString() {
    return 'CategoryFilterRouteArgs{key: $key, tag: $tag, name: $name}';
  }
}

/// generated route for
/// [_i1.LikedLocationsScreen]
class LikedLocationsRoute extends _i2.PageRouteInfo<void> {
  const LikedLocationsRoute() : super(LikedLocationsRoute.name, path: 'likes');

  static const String name = 'LikedLocationsRoute';
}

/// generated route for
/// [_i1.BookmarkedLocationsScreen]
class BookmarkedLocationsRoute extends _i2.PageRouteInfo<void> {
  const BookmarkedLocationsRoute()
      : super(BookmarkedLocationsRoute.name, path: 'bookmarks');

  static const String name = 'BookmarkedLocationsRoute';
}

/// generated route for
/// [_i1.PlaceDetailsScreen]
class LocationRoute extends _i2.PageRouteInfo<LocationRouteArgs> {
  LocationRoute(
      {_i3.Key? key,
      required _i6.PlaceModel place,
      required String heroTag,
      _i3.Animation<double>? transitionAnimation})
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

  final _i3.Key? key;

  final _i6.PlaceModel place;

  final String heroTag;

  final _i3.Animation<double>? transitionAnimation;

  @override
  String toString() {
    return 'LocationRouteArgs{key: $key, place: $place, heroTag: $heroTag, transitionAnimation: $transitionAnimation}';
  }
}

/// generated route for
/// [_i1.PlaceReviewsScreen]
class PlaceReviewsRoute extends _i2.PageRouteInfo<PlaceReviewsRouteArgs> {
  PlaceReviewsRoute({_i3.Key? key, required String id})
      : super(PlaceReviewsRoute.name,
            path: 'reviews/:id',
            args: PlaceReviewsRouteArgs(key: key, id: id),
            rawPathParams: {'id': id});

  static const String name = 'PlaceReviewsRoute';
}

class PlaceReviewsRouteArgs {
  const PlaceReviewsRouteArgs({this.key, required this.id});

  final _i3.Key? key;

  final String id;

  @override
  String toString() {
    return 'PlaceReviewsRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i2.EmptyRouterPage]
class RestaurantsRouter extends _i2.PageRouteInfo<void> {
  const RestaurantsRouter({List<_i2.PageRouteInfo>? children})
      : super(RestaurantsRouter.name,
            path: 'restaurants', initialChildren: children);

  static const String name = 'RestaurantsRouter';
}

/// generated route for
/// [_i1.GalleryScreen]
class GalleryRoute extends _i2.PageRouteInfo<GalleryRouteArgs> {
  GalleryRoute({_i3.Key? key, required String id, int index = 0})
      : super(GalleryRoute.name,
            path: 'gallery/:index',
            args: GalleryRouteArgs(key: key, id: id, index: index),
            rawPathParams: {'id': id, 'index': index});

  static const String name = 'GalleryRoute';
}

class GalleryRouteArgs {
  const GalleryRouteArgs({this.key, required this.id, this.index = 0});

  final _i3.Key? key;

  final String id;

  final int index;

  @override
  String toString() {
    return 'GalleryRouteArgs{key: $key, id: $id, index: $index}';
  }
}

/// generated route for
/// [_i2.EmptyRouterPage]
class LodgingRouter extends _i2.PageRouteInfo<void> {
  const LodgingRouter({List<_i2.PageRouteInfo>? children})
      : super(LodgingRouter.name, path: 'lodging', initialChildren: children);

  static const String name = 'LodgingRouter';
}

/// generated route for
/// [_i1.RestaurantsScreen]
class RestaurantsRoute extends _i2.PageRouteInfo<RestaurantsRouteArgs> {
  RestaurantsRoute({required String locId, _i3.Key? key})
      : super(RestaurantsRoute.name,
            path: '', args: RestaurantsRouteArgs(locId: locId, key: key));

  static const String name = 'RestaurantsRoute';
}

class RestaurantsRouteArgs {
  const RestaurantsRouteArgs({required this.locId, this.key});

  final String locId;

  final _i3.Key? key;

  @override
  String toString() {
    return 'RestaurantsRouteArgs{locId: $locId, key: $key}';
  }
}

/// generated route for
/// [_i1.GMapsDetailsScreen]
class GMapsDetailsRoute extends _i2.PageRouteInfo<GMapsDetailsRouteArgs> {
  GMapsDetailsRoute(
      {_i3.Key? key,
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

  final _i3.Key? key;

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
class LodgingRoute extends _i2.PageRouteInfo<LodgingRouteArgs> {
  LodgingRoute({required String locId, _i3.Key? key})
      : super(LodgingRoute.name,
            path: '', args: LodgingRouteArgs(locId: locId, key: key));

  static const String name = 'LodgingRoute';
}

class LodgingRouteArgs {
  const LodgingRouteArgs({required this.locId, this.key});

  final String locId;

  final _i3.Key? key;

  @override
  String toString() {
    return 'LodgingRouteArgs{locId: $locId, key: $key}';
  }
}
