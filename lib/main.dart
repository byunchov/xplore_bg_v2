import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/infrastructure/theme/apptheme.provider.dart';
import 'package:xplore_bg_v2/infrastructure/theme/themes.dart';
import 'package:xplore_bg_v2/initializer.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/gmaps.provider.dart';

// TODO Add user model and update auth provider and repo - DONE
// TODO create loading card for featured places - DONE
// TODO fix user auth on app load
// TODO refactor explore screen - DONE
// TODO add user loaction service and acc. providers - DONE
// TODO finish user screen - DONE
// TODO add user profile edit - DROPPED
// TODO add user auth checks troughout buttons
// TODO add show more screen and acc. providers - DONE
// TODO add review content page - DONE
// TODO add clear all in category filter page - DROPPED
// TODO add nearby section to place details - DONE
// TODO add change language menu and screen -DONE
// TODO add language provider - DONE

void main() async {
  await Initializer.init();

  final restaurantPinBitmapArray =
      await GMapsUtils.getBytesFromAsset(AppConfig.restaurantPinIcon, 95);
  final lodgingPinBitmapArray = await GMapsUtils.getBytesFromAsset(AppConfig.hotelPinIcon, 95);

  runApp(
    EasyLocalization(
      path: "assets/translations",
      supportedLocales: AppConfig.appLocales,
      fallbackLocale: const Locale("bg"),
      startLocale: const Locale("bg"),
      useOnlyLangCode: true,
      child: ProviderScope(
        child: const MainApplication(),
        overrides: [
          restaurantPinBitmapProvider.overrideWithValue(restaurantPinBitmapArray),
          lodgingPinBitmapProvider.overrideWithValue(lodgingPinBitmapArray),
        ],
      ),
    ),
  );
}

class MainApplication extends ConsumerWidget {
  const MainApplication({Key? key}) : super(key: key);

  // final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(appThemeProvider.notifier).loadThemeMode();
    final darkModeEnabled = ref.watch(appThemeProvider);
    final appRouter = ref.read(appRouterProvider);

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
