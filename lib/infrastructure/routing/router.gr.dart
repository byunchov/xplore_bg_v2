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
import 'package:flutter/material.dart' as _i10;
import 'package:xplore_bg_v2/models/models.dart' as _i11;
import 'package:xplore_bg_v2/presentation/bookmarks/bookmarked.screen.dart'
    as _i6;
import 'package:xplore_bg_v2/presentation/bookmarks/liked.screen.dart' as _i5;
import 'package:xplore_bg_v2/presentation/category/category.screen.dart' as _i3;
import 'package:xplore_bg_v2/presentation/category/category_filters.screen.dart'
    as _i4;
import 'package:xplore_bg_v2/presentation/place/place.screen.dart' as _i7;
import 'package:xplore_bg_v2/presentation/restaurants/restaurant_deatils.screen.dart'
    as _i9;
import 'package:xplore_bg_v2/presentation/restaurants/restaurants.screen.dart'
    as _i8;
import 'package:xplore_bg_v2/presentation/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    SigninRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.SignInScreen());
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
          child: _i3.CategoryScreen(
              key: args.key, tag: args.tag, category: args.category));
    },
    CategoryFilterRoute.name: (routeData) {
      final args = routeData.argsAs<CategoryFilterRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i4.CategoryFilterScreen(
              key: args.key, tag: args.tag, name: args.name));
    },
    LikedLocationsRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.LikedLocationsScreen());
    },
    BookmarkedLocationsRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i6.BookmarkedLocationsScreen());
    },
    LocationRoute.name: (routeData) {
      final args = routeData.argsAs<LocationRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i7.PlaceDetailsScreen(
              key: args.key,
              place: args.place,
              transitionAnimation: args.transitionAnimation));
    },
    RestaurantsRouter.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.EmptyRouterPage());
    },
    RestaurantsRoute.name: (routeData) {
      final args = routeData.argsAs<RestaurantsRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i8.RestaurantsScreen(args.location, key: args.key));
    },
    RestaurantDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<RestaurantDetailsRouteArgs>();
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i9.RestaurantDetailsScreen(
              key: args.key, id: args.id, restaurant: args.restaurant));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/', children: [
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
          _i2.RouteConfig(RestaurantsRouter.name,
              path: 'restaurants',
              parent: LocationRouter.name,
              children: [
                _i2.RouteConfig(RestaurantsRoute.name,
                    path: '', parent: RestaurantsRouter.name),
                _i2.RouteConfig(RestaurantDetailsRoute.name,
                    path: ':id', parent: RestaurantsRouter.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.SignInScreen]
class SigninRoute extends _i2.PageRouteInfo<void> {
  const SigninRoute() : super(SigninRoute.name, path: '/signin');

  static const String name = 'SigninRoute';
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
/// [_i3.CategoryScreen]
class CategoryRoute extends _i2.PageRouteInfo<CategoryRouteArgs> {
  CategoryRoute(
      {_i10.Key? key, required String tag, _i11.CategoryModel? category})
      : super(CategoryRoute.name,
            path: ':tag',
            args: CategoryRouteArgs(key: key, tag: tag, category: category),
            rawPathParams: {'tag': tag});

  static const String name = 'CategoryRoute';
}

class CategoryRouteArgs {
  const CategoryRouteArgs({this.key, required this.tag, this.category});

  final _i10.Key? key;

  final String tag;

  final _i11.CategoryModel? category;

  @override
  String toString() {
    return 'CategoryRouteArgs{key: $key, tag: $tag, category: $category}';
  }
}

/// generated route for
/// [_i4.CategoryFilterScreen]
class CategoryFilterRoute extends _i2.PageRouteInfo<CategoryFilterRouteArgs> {
  CategoryFilterRoute(
      {_i10.Key? key, required String tag, required String name})
      : super(CategoryFilterRoute.name,
            path: ':tag/filters',
            args: CategoryFilterRouteArgs(key: key, tag: tag, name: name));

  static const String name = 'CategoryFilterRoute';
}

class CategoryFilterRouteArgs {
  const CategoryFilterRouteArgs(
      {this.key, required this.tag, required this.name});

  final _i10.Key? key;

  final String tag;

  final String name;

  @override
  String toString() {
    return 'CategoryFilterRouteArgs{key: $key, tag: $tag, name: $name}';
  }
}

/// generated route for
/// [_i5.LikedLocationsScreen]
class LikedLocationsRoute extends _i2.PageRouteInfo<void> {
  const LikedLocationsRoute() : super(LikedLocationsRoute.name, path: 'likes');

  static const String name = 'LikedLocationsRoute';
}

/// generated route for
/// [_i6.BookmarkedLocationsScreen]
class BookmarkedLocationsRoute extends _i2.PageRouteInfo<void> {
  const BookmarkedLocationsRoute()
      : super(BookmarkedLocationsRoute.name, path: 'bookmarks');

  static const String name = 'BookmarkedLocationsRoute';
}

/// generated route for
/// [_i7.PlaceDetailsScreen]
class LocationRoute extends _i2.PageRouteInfo<LocationRouteArgs> {
  LocationRoute(
      {_i10.Key? key,
      required _i11.PlaceModel place,
      _i10.Animation<double>? transitionAnimation})
      : super(LocationRoute.name,
            path: '',
            args: LocationRouteArgs(
                key: key,
                place: place,
                transitionAnimation: transitionAnimation));

  static const String name = 'LocationRoute';
}

class LocationRouteArgs {
  const LocationRouteArgs(
      {this.key, required this.place, this.transitionAnimation});

  final _i10.Key? key;

  final _i11.PlaceModel place;

  final _i10.Animation<double>? transitionAnimation;

  @override
  String toString() {
    return 'LocationRouteArgs{key: $key, place: $place, transitionAnimation: $transitionAnimation}';
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
/// [_i8.RestaurantsScreen]
class RestaurantsRoute extends _i2.PageRouteInfo<RestaurantsRouteArgs> {
  RestaurantsRoute({required _i11.LocationModel location, _i10.Key? key})
      : super(RestaurantsRoute.name,
            path: '', args: RestaurantsRouteArgs(location: location, key: key));

  static const String name = 'RestaurantsRoute';
}

class RestaurantsRouteArgs {
  const RestaurantsRouteArgs({required this.location, this.key});

  final _i11.LocationModel location;

  final _i10.Key? key;

  @override
  String toString() {
    return 'RestaurantsRouteArgs{location: $location, key: $key}';
  }
}

/// generated route for
/// [_i9.RestaurantDetailsScreen]
class RestaurantDetailsRoute
    extends _i2.PageRouteInfo<RestaurantDetailsRouteArgs> {
  RestaurantDetailsRoute(
      {_i10.Key? key,
      required String id,
      required _i11.RestaurantModel restaurant})
      : super(RestaurantDetailsRoute.name,
            path: ':id',
            args: RestaurantDetailsRouteArgs(
                key: key, id: id, restaurant: restaurant),
            rawPathParams: {'id': id});

  static const String name = 'RestaurantDetailsRoute';
}

class RestaurantDetailsRouteArgs {
  const RestaurantDetailsRouteArgs(
      {this.key, required this.id, required this.restaurant});

  final _i10.Key? key;

  final String id;

  final _i11.RestaurantModel restaurant;

  @override
  String toString() {
    return 'RestaurantDetailsRouteArgs{key: $key, id: $id, restaurant: $restaurant}';
  }
}
