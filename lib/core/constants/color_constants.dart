import 'package:flutter/material.dart';

/// Color constants for consistent theming
class ColorConstants {
  // Primary Colors - Cool Modern Palette
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);

  // Secondary Colors - Cool Gradient Inspired
  static const Color secondary = Color(0xFFEC4899); // Pink
  static const Color secondaryDark = Color(0xFFDB2777);
  static const Color secondaryLight = Color(0xFFF472B6);

  // Error Colors
  static const Color error = Color(0xFFB00020);
  static const Color errorDark = Color(0xFF790000);
  static const Color errorLight = Color(0xFFCF6679);

  // Warning Colors
  static const Color warning = Color(0xFFFF9800);
  static const Color warningDark = Color(0xFFE65100);
  static const Color warningLight = Color(0xFFFFB74D);

  // Success Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF388E3C);
  static const Color successLight = Color(0xFF81C784);

  // Info Colors
  static const Color info = Color(0xFF2196F3);
  static const Color infoDark = Color(0xFF1976D2);
  static const Color infoLight = Color(0xFF64B5F6);

  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Color(0x00000000);

  // Grey Scale
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // Background Colors - Cool Modern Theme
  static const Color backgroundLight = Color(0xFFF8FAFC); // Soft gray-blue
  static const Color backgroundDark = Color(0xFF0F172A); // Deep slate
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E293B); // Modern dark surface

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textHintLight = Color(0xFFBDBDBD);

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB3B3B3);
  static const Color textHintDark = Color(0xFF757575);

  // Border Colors
  static const Color borderLight = grey300;
  static const Color borderDark = grey700;

  // Shadow Colors
  static const Color shadowLight = black;
  static const Color shadowDark = black;

  // Accent Colors
  static const Color accent = Color(0xFF06B6D4); // Cyan
  static const Color accentLight = Color(0xFF67E8F9);
  static const Color accentDark = Color(0xFF0891B2);

  // Gradient Colors
  static const Color gradientStart = Color(0xFF6366F1);
  static const Color gradientMiddle = Color(0xFFEC4899);
  static const Color gradientEnd = Color(0xFF06B6D4);

  // Special Colors
  static const Color overlay = Color(0x80000000); // Black with 50% opacity
  static const Color divider = grey300;
  static const Color ripple = Color(0x1F000000); // Black with 12% opacity

  // Utility methods for theme-aware colors
  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textPrimaryDark
        : textPrimaryLight;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textSecondaryDark
        : textSecondaryLight;
  }

  static Color getTextHint(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? textHintDark
        : textHintLight;
  }

  static Color getBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? backgroundDark
        : backgroundLight;
  }

  static Color getSurface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? surfaceDark
        : surfaceLight;
  }

  static Color getBorder(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? borderDark
        : borderLight;
  }
}
