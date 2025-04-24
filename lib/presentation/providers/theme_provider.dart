import 'package:flutter/material.dart';
import '../../core/services/preference_service.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeProvider(this._themeMode);

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    PreferenceService.setThemeMode(_themeMode);
    notifyListeners();
  }
}
