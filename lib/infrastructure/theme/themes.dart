import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static const kNavbarThemeData = BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Colors.cyan,
    elevation: 4,
  );

  // static const kAppBarThemeData = AppBarTheme(
  //   elevation: 2,
  //   toolbarHeight: 70,
  //   // backgroundColor: Colors.transparent,
  //   // color: Colors.transparent,
  //   systemOverlayStyle: SystemUiOverlayStyle.dark,
  //   iconTheme: IconThemeData(color: Colors.black),
  // );

  static final kXploreAppbarColorLigth = Colors.grey[200];
  static final kXploreAppbarColorDark = Colors.grey[800];

  static Color? xploreAppbarColor(Brightness brightness) {
    return brightness == Brightness.light ? kXploreAppbarColorLigth : kXploreAppbarColorDark;
  }

  static final ThemeData kLigthtTheme = ThemeData.light().copyWith(
    listTileTheme: ListTileThemeData(tileColor: Colors.grey[200]),
    dialogTheme: const DialogTheme(backgroundColor: Colors.white),
    dialogBackgroundColor: Colors.black.withOpacity(0.7),
    // appBarTheme: kAppBarThemeData.copyWith(color: Colors.grey[200], foregroundColor: Colors.black),
    appBarTheme: AppBarTheme(
      elevation: 2,
      toolbarHeight: 70,
      backgroundColor: Colors.grey[50],
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: const IconThemeData(color: Colors.black),
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: kNavbarThemeData,
    primaryColor: Colors.cyan[700],
  );

  static final ThemeData kDarkTheme = ThemeData.dark().copyWith(
    listTileTheme: ListTileThemeData(tileColor: Colors.grey[800]),
    dialogTheme: DialogTheme(backgroundColor: Colors.grey[850]),
    dialogBackgroundColor: Colors.black.withOpacity(0.7),
    appBarTheme: const AppBarTheme(
      elevation: 2,
      toolbarHeight: 70,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      iconTheme: IconThemeData(color: Colors.white),
      // foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: kNavbarThemeData.copyWith(backgroundColor: Colors.grey[800]),
    primaryColor: Colors.cyan[700],
  );
}
