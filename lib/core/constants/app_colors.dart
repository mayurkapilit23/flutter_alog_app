import 'package:flutter/material.dart';

class AppColors {
  // Base Colors
  static const Color scaffoldBackground = Color(0xFF0D0D1A);
  static const Color cardBackground = Color(0x0AFFFFFF); // white with 0.04 opacity
  static const Color seedColor = Color(0xFF1A1A2E);
  
  // Rule Colors
  static const Color ruleOdd = Color(0xFF4FC3F7);
  static const Color ruleEven = Color(0xFF81C784);
  static const Color rulePrime = Color(0xFFFFB74D);
  static const Color ruleFibonacci = Color(0xFFF06292);

  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white54;
  static const Color textTertiary = Colors.white38;
  static const Color textQuaternary = Colors.white30;
  static const Color textMuted = Colors.white24;

  // Border Colors
  static const Color borderLight = Color(0x12FFFFFF); // white with 0.07 opacity
  static const Color borderSubtle = Color(0x0FFFFFFF); // white with 0.06 opacity
  static const Color borderMuted = Color(0x0DFFFFFF); // white with 0.05 opacity
  static const Color borderHighlight = Color(0x14FFFFFF); // white with 0.08 opacity

  // Helper for dynamic opacities if needed
  static Color whiteWithOpacity(double opacity) => Colors.white.withOpacity(opacity);
}
