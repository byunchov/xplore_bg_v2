import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/theme/apptheme.provider.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/initializer.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/gmaps.provider.dart';

void main() async {
  await Initializer.init();

  final restaurantPinBitmapArray =
      await GMapsUtils.getBytesFromAsset(AppConfig.restaurantPinIcon, 95);
  final lodgingPinBitmapArray = await GMapsUtils.getBytesFromAsset(AppConfig.hotelPinIcon, 95);

  runApp(
    EasyLocalization(
      path: "assets/translations",
      supportedLocales: AppConfig.appLocales,
      fallbackLocale: AppConfig.appLocales.first,
      startLocale: AppConfig.appLocales.first,
      useOnlyLangCode: true,
      child: ProviderScope(
        child: const _MaterialApp(),
        overrides: [
          restaurantPinBitmapProvider.overrideWithValue(restaurantPinBitmapArray),
          lodgingPinBitmapProvider.overrideWithValue(lodgingPinBitmapArray),
        ],
      ),
    ),
  );
}

class _MaterialApp extends ConsumerWidget {
  const _MaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(appThemeProvider.notifier).loadThemeMode();
    final darkModeEnabled = ref.watch(appThemeProvider);

    final appRouter = ref.read(appRouterProvider);

    ref.read(appLocaleProvider.notifier).setAppLocale(context.locale);

    FlutterNativeSplash.remove();

    return MaterialApp.router(
      title: AppConfig.appName,
      theme: AppThemes.kLigthtTheme,
      darkTheme: AppThemes.kDarkTheme,
      themeMode: darkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      routerDelegate: appRouter.delegate(
        navigatorObservers: () => [HeroController()],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}

// flutter pub global run dcdg -o uml_diagram.puml --exclude '*.g.dart' --exclude '*.freezed.dart'