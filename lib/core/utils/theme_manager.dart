import 'package:flutter/material.dart';
import '../constants/app_color.dart';

class ThemeManager {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.lightBackground,
    primaryColor: AppColor.lightPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.lightPrimary,
      foregroundColor: Colors.white,
    ),
    cardColor: AppColor.lightCard,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColor.lightText),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.orange,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColor.lightPrimary,
      secondary: AppColor.orange,
      background: AppColor.lightBackground,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColor.darkBackground,
    primaryColor: AppColor.darkPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkPrimary,
      foregroundColor: Colors.white,
    ),
    cardColor: AppColor.darkCard,
    textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColor.darkText)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.orange,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColor.darkPrimary,
      secondary: AppColor.orange,
      background: AppColor.darkBackground,
    ),
  );
}
