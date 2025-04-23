import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setLoginStatus(bool value) async {
    await _prefs.setBool('is_logged_in', value);
  }

  static bool getLoginStatus() {
    return _prefs.getBool('is_logged_In') ?? false;
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString('theme_Mode', mode.name);
  }

  static ThemeMode getThemeMode() {
    final value = _prefs.getString('theme_Mode');
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  static Future<void> logout() async {
    await _prefs.remove('is_Logged_In');
  }
}
