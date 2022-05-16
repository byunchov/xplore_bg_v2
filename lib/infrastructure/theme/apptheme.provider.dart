import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xplore_bg_v2/domain/core/constants/storage.constants.dart';

// Theme
final appThemeProvider = StateNotifierProvider<AppThemeState, bool>((ref) => AppThemeState());

class AppThemeState extends StateNotifier<bool> {
  final GetStorage _box = GetStorage();

  AppThemeState() : super(false);

  void _changeSystemNavbarTheme() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: state ? Colors.grey[800] : Colors.white,
        systemNavigationBarIconBrightness: state ? Brightness.light : Brightness.dark,
      ),
    );
  }

  void loadThemeMode() {
    state = _box.read(StorageConstants.appThemeMode) ?? false;
    _changeSystemNavbarTheme();
  }

  void setThemeMode(bool mode) {
    state = mode;
    _box.write(StorageConstants.appThemeMode, state);
    _changeSystemNavbarTheme();
  }
}
