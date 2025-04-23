import 'package:attendly_app/core/services/preference_service.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeProvider(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    PreferenceService.setThemeMode(
      _themeMode,
    ); // Save the theme mode to shared preferences
    notifyListeners();
  }
}
