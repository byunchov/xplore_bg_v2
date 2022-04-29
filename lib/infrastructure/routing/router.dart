import 'package:auto_route/auto_route.dart';
import 'package:xplore_bg_v2/presentation/bookmarks/bookmarked.screen.dart';
import 'package:xplore_bg_v2/presentation/bookmarks/liked.screen.dart';
import 'package:xplore_bg_v2/presentation/category/category.screen.dart';
import 'package:xplore_bg_v2/presentation/category/category_filters.screen.dart';
import 'package:xplore_bg_v2/presentation/gallery/gallery.screen.dart';
import 'package:xplore_bg_v2/presentation/launcher/auth_checker.screen.dart';
import 'package:xplore_bg_v2/presentation/place/place.screen.dart';
import 'package:xplore_bg_v2/presentation/restaurants/restaurant_deatils.screen.dart';
import 'package:xplore_bg_v2/presentation/restaurants/restaurants.screen.dart';
import 'package:xplore_bg_v2/presentation/screens.dart';

/* @MaterialAutoRouter(
  
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true, children: [
      AutoRoute(path: 'explore', page: ExploreScreen),
      AutoRoute(
        path: 'categories',
        page: LandmarkCategoriesScreen,
        children: [
          AutoRoute(
            path: ':tag',
            page: CategoryScreen,
            // children: [
            //   AutoRoute(path: 'filters'),
            // ],
          ),
        ],
      ),
      AutoRoute(
        path: 'bookmarks',
        page: BookmarksScreen,
        children: [
          AutoRoute(path: 'likes', page: LikedLocationsScreen),
          AutoRoute(path: 'bookmark', page: BookmarkedLocationsScreen),
        ],
      ),
      AutoRoute(path: 'user', page: UserProfileScreen),
    ]),
    AutoRoute(path: '/signin', page: SignInScreen),
    AutoRoute(
      path: "/location",
      page: PlaceDetailsScreen,
      children: [
        AutoRoute(path: 'restaurants', page: RestaurantsScreen, children: [
          AutoRoute(path: ":id", page: RestaurantDetailsScreen),
        ]),
        // AutoRoute(path: 'hotels', page: RestaurantsScreen, children: [
        //   AutoRoute(path: ":id", page: RestaurantDetailsScreen),
        // ]),
      ],
    ),
  ],
)
 */

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: [
    AutoRoute(
      initial: true,
      page: AuthCheckerScreen,
    ),
    AutoRoute(
      path: "/home",
      page: HomeScreen,
      children: [
        AutoRoute(path: 'explore', page: ExploreScreen),
        AutoRoute(
          path: 'categories',
          name: 'LandmarksRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: LandmarkCategoriesScreen),
            AutoRoute(path: ':tag', page: CategoryScreen),
            AutoRoute(path: ':tag/filters', page: CategoryFilterScreen),
          ],
        ),
        AutoRoute(
          path: 'bookmarks',
          name: "NotedLocationsRouter",
          page: BookmarksScreen,
          children: [
            // AutoRoute(path: '', page: BookmarksScreen),
            AutoRoute(path: 'likes', page: LikedLocationsScreen),
            AutoRoute(path: 'bookmarks', page: BookmarkedLocationsScreen),
          ],
        ),
        AutoRoute(path: 'user', page: UserProfileScreen),
      ],
    ),
    AutoRoute(path: '/signin', name: "SigninRoute", page: SignInScreen),
    AutoRoute(path: '/search', page: SearchScreen),
    AutoRoute(
      path: "/location",
      name: "LocationRouter",
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', name: "LocationRoute", page: PlaceDetailsScreen),
        AutoRoute(
          path: 'restaurants',
          name: "RestaurantsRouter",
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: RestaurantsScreen),
            AutoRoute(path: ":id", page: RestaurantDetailsScreen),
          ],
        ),
        AutoRoute(path: 'gallery/:index', page: GalleryScreen),
        // AutoRoute(path: 'hotels', page: RestaurantsScreen, children: [
        //   AutoRoute(path: ":id", page: RestaurantDetailsScreen),
        // ]),
      ],
    ),
  ],
)

//flutter pub run build_runner build --delete-conflicting-outputs
//flutter pub run build_runner watch --delete-conflicting-outputs
class $AppRouter {}
