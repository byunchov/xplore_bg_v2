import 'dart:ui';

class AppConfig {
  static const String appName = "Xplore Bulgaria";
  static final List<String> appLanguages = ["Български", "English"];
  static final List<Locale> appLocales = [const Locale('bg'), const Locale('en')];
  static const Locale defaultLocale = Locale('bg');
  static const String appLogo = 'assets/images/logo.png';

  //google maps
  static const String hotelIcon = 'assets/images/maps/hotel.png';
  static const String restaurantIcon = 'assets/images/maps/restaurant.png';
  static const String hotelPinIcon = 'assets/images/maps/hotel_pin.png';
  static const String restaurantPinIcon = 'assets/images/maps/restaurant_pin.png';

  //user related
  static const String defaultProfilePic =
      'https://www.seekpng.com/png/detail/114-1149972_avatar-free-png-image-avatar-png.png';

  static const String mailTo = "mailto:$supportEmail?subject=About $appName App&body=";

  static const String supportEmail = 'xplorebg.project@gmail.com';
  static const String privacyPolicyUrl =
      "https://www.privacypolicies.com/live/dbb3bb87-d6e4-4ae4-a7ca-879bc62c0fc1";
}
