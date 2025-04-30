import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_color.dart';

class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.lightPrimary,
    scaffoldBackgroundColor: AppColor.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColor.lightPrimary,
      secondary: AppColor.lightAccent,
      surface: AppColor.lightCard,
      background: AppColor.lightBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.lightBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.lightPrimary),
      titleTextStyle: TextStyle(
        color: AppColor.lightText,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColor.lightBackground,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColor.lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.lightPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.lightPrimary,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColor.lightText,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColor.lightText,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: AppColor.lightText.withOpacity(0.8)),
      bodyMedium: TextStyle(color: AppColor.lightText.withOpacity(0.7)),
    ),
    iconTheme: const IconThemeData(color: AppColor.lightPrimary),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.lightCard,
      selectedItemColor: AppColor.lightAccent,
      unselectedItemColor: AppColor.lightText.withOpacity(0.5),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.orange,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.darkPrimary,
    scaffoldBackgroundColor: AppColor.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColor.darkPrimary,
      secondary: AppColor.darkAccent,
      surface: AppColor.darkCard,
      background: AppColor.darkBackground,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColor.darkBackground,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColor.darkPrimary),
      titleTextStyle: TextStyle(
        color: AppColor.darkText,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColor.darkBackground,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    cardTheme: CardTheme(
      color: AppColor.darkCard,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColor.darkPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColor.darkPrimary,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: AppColor.darkText,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: AppColor.darkText,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: AppColor.darkText.withOpacity(0.8)),
      bodyMedium: TextStyle(color: AppColor.darkText.withOpacity(0.7)),
    ),
    iconTheme: const IconThemeData(color: AppColor.darkPrimary),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColor.darkCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.darkCard,
      selectedItemColor: AppColor.darkAccent,
      unselectedItemColor: AppColor.darkText.withOpacity(0.5),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.orange,
    ),
  );
}
