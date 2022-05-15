import 'package:auto_route/auto_route.dart';
import 'package:xplore_bg_v2/infrastructure/routing/auth.guard.dart';
import 'package:xplore_bg_v2/presentation/explore/show_more_nearby.screen.dart';
import 'package:xplore_bg_v2/presentation/location/reviews/add_review.screen.dart';
import 'package:xplore_bg_v2/presentation/screens.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: [
    AutoRoute(
      // initial: true,
      page: AuthCheckerScreen,
      // guards: [AuthGuard],
    ),
    AutoRoute(
      initial: true,
      guards: [AuthGuard],
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
          page: NotedScreen,
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
    AutoRoute(path: '/language', page: ChooseLanguageScreen),
    AutoRoute(path: '/nearby', page: ShowMoreNearbyScreen),
    AutoRoute(
      path: "/location",
      name: "LocationRouter",
      page: EmptyRouterPage,
      children: [
        AutoRoute(path: '', name: "LocationRoute", page: PlaceDetailsScreen),
        AutoRoute(path: 'reviews/:id', page: PlaceReviewsScreen),
        AutoRoute(path: 'review/:id', page: AddReviewScreen),
        AutoRoute(
          path: 'restaurants',
          name: "RestaurantsRouter",
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: RestaurantsScreen),
            AutoRoute(path: ":id", page: GMapsDetailsScreen),
          ],
        ),
        AutoRoute(path: 'gallery/:index', page: GalleryScreen),
        AutoRoute(
          path: 'lodging',
          name: "LodgingRouter",
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: LodgingScreen),
            AutoRoute(path: ":id", page: GMapsDetailsScreen),
          ],
        ),
      ],
    ),
  ],
)

//flutter pub run build_runner build --delete-conflicting-outputs
//flutter pub run build_runner watch --delete-conflicting-outputs
class $AppRouter {}
