import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static late SharedPreferences _prefs;

  /// Initialize SharedPreferences once before app runs
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Save login session
  static Future<void> setLoginStatus(bool value) async {
    await _prefs.setBool('is_logged_in', value);
  }

  /// Read login session
  static bool getLoginStatus() {
    return _prefs.getBool('is_logged_in') ?? false;
  }

  /// Save theme mode
  static Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString('theme_mode', mode.name);
  }

  /// Read theme mode
  static ThemeMode getThemeMode() {
    final value = _prefs.getString('theme_mode');
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  /// Logout: clear login status
  static Future<void> logout() async {
    await _prefs.remove('is_logged_in');
    // Optional: await _prefs.clear(); // to clear everything
  }
}
