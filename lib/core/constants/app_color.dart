import 'package:flutter/material.dart';

class AppColor {
  // Main Theme Colors
  static const orange = Color(0xFFFF9F43); // Vibrant orange from clock/calendar
  static const lightBlue = Color(0xFFD6E6F2); // Background blue
  static const darkBlue = Color(0xFF1E3A8A); // People's clothing, clock hands
  static const creamYellow = Color(0xFFFFF3C4); // Calendar cells
  static const leafGreen = Color(0xFF7BAE7F); // Plants in image

  // Status Colors
  static const success = Color(0xFF2ECC71); // Green checkmarks
  static const error = Color(0xFFE74C3C); // For errors/warnings
  static const neutral = Color(0xFFBDBDBD); // Neutral gray

  // Light Theme
  static const lightBackground = Color(0xFFD6E6F2); // Light blue background
  static const lightPrimary = Color(0xFF1E3A8A); // Dark blue primary
  static const lightAccent = Color(0xFFFF9F43); // Orange accent
  static const lightText = Color(0xFF2C3E50); // Dark text
  static const lightCard = Color(0xFFFFFFFF); // White cards

  // Dark Theme
  static const darkBackground = Color(0xFF172554); // Darker blue background
  static const darkPrimary = Color(0xFF60A5FA); // Lighter blue as primary
  static const darkAccent = Color(0xFFFF9F43); // Same orange accent
  static const darkText = Color(0xFFE5E5E5); // Light text
  static const darkCard = Color(0xFF1E293B); // Dark blue cards

  // Additional UI Elements
  static const calendarHeader = orange;
  static const calendarCell = creamYellow;
  static const checkmark = success;
  static const clockFace = lightCard;
  static const clockRim = orange;
  static const clockHands = darkBlue;
}
