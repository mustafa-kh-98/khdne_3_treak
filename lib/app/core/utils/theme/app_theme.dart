import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../app_colors.dart';
import '../app_storage.dart';

class AppTheme {
  static ThemeData light = lightTheme;
  static ThemeData dark = darkTheme;

  static String get appFontFamily => "Somar";

  static bool get isDark => Get.isDarkMode;

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  bool isSavedDarkMode() {
    return AppStorage.read(AppStorage.DARK_MODE_KEY) ?? false;
  }

  Future saveThemeMode(bool isDarkMode) =>
      AppStorage.write(AppStorage.DARK_MODE_KEY, isDarkMode);

  Future changeThemeMode([bool? isDarkMode]) async {
    await saveThemeMode(isDarkMode ?? !isSavedDarkMode());
    Get.changeThemeMode(
        !(isDarkMode ?? isSavedDarkMode()) ? ThemeMode.light : ThemeMode.dark);
  }
}

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[900],
  cardColor: Colors.grey[800],
  secondaryHeaderColor: Colors.grey[700],
  appBarTheme: AppBarTheme(
    color: Colors.grey[900],
    elevation: 2,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  dividerColor: Colors.grey[700],
  primaryColor: Colors.red[400],
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:  AppBarTheme(
    shadowColor:AppColors.GRAY2.withOpacity(.5),
    backgroundColor: AppColors.PRIMARY_LIGHT_COLOR,
    elevation: .1,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.white,
    ),
  ),
);
