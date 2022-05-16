import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/constants/storage.constants.dart';

class AppLocaleState extends StateNotifier<Locale> {
  final GetStorage _box = GetStorage();

  AppLocaleState() : super(const Locale('bg'));

  void loadAppLocale() {
    final lang = _box.read<String>(StorageConstants.appLocale) ?? "bg";
    state = Locale(lang);
  }

  void setAppLocale(Locale locale) {
    state = locale;
    // _box.write(StorageConstants.appLocale, state.languageCode);
  }
}
