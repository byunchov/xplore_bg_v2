import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/infrastructure/theme/apptheme.provider.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/initializer.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/gmaps.provider.dart';

void main() async {
  await Initializer.init();

  final restaurantPinBitmapArray =
      await GMapsUtils.getBytesFromAsset(AppConfig.restaurantPinIcon, 95);
  final lodgingPinBitmapArray = await GMapsUtils.getBytesFromAsset(AppConfig.hotelPinIcon, 95);

  print(restaurantPinBitmapArray);

  runApp(
    EasyLocalization(
      path: "assets/translations",
      supportedLocales: AppConfig.appLocales,
      fallbackLocale: const Locale("bg"),
      startLocale: const Locale("bg"),
      useOnlyLangCode: true,
      child: ProviderScope(
        child: MainApplication(),
        overrides: [
          restaurantPinBitmapProvider.overrideWithValue(restaurantPinBitmapArray),
          lodgingPinBitmapProvider.overrideWithValue(lodgingPinBitmapArray),
        ],
      ),
    ),
  );
}

class MainApplication extends ConsumerWidget {
  MainApplication({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(appThemeProvider.notifier).loadThemeMode();
    final darkModeEnabled = ref.watch(appThemeProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      theme: AppThemes.kLigthtTheme,
      darkTheme: AppThemes.kDarkTheme,
      themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [HeroController()],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}

/* 
class MyApp extends ConsumerWidget {
  MyApp({Key? key}) : super(key: key);
  final _appRouter = AppRouter(authGuard: AuthGuard(ref));

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(appThemeProvider.notifier).loadThemeMode();
    final darkModeEnabled = ref.watch(appThemeProvider);
    final auth = ref.watch(authControllerProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      theme: AppThemes.kLigthtTheme,
      darkTheme: AppThemes.kDarkTheme,
      themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      // routerDelegate: _appRouter.declarativeDelegate(
      //   routes: (ctx) {
      //     final user = ref.read(authControllerProvider);
      //     return [
      //       if (user != null) const HomeRoute() else const SigninRoute(),
      //     ];
      //   },
      // ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      // home: const PlaceDetailsScreen(),
    );
  }
}
 */