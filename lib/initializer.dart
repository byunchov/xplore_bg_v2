import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xplore_bg_v2/firebase_options.dart';

class Initializer {
  static Future<void> init() async {
    try {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
      await dotenv.load(fileName: ".env");
      await _initStorage();
      _initScreenPreference();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    } catch (err) {
      rethrow;
    }
  }

  static Future<void> _initStorage() async {
    await GetStorage.init();
    Get.put(GetStorage());
  }

  static void _initScreenPreference() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
