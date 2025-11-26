import 'package:flutter/material.dart';

/// UI Constants for consistent design system
class UiConstants {
  // Spacing
  static const double spacing2 = 2.0;
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing56 = 56.0;
  static const double spacing64 = 64.0;

  // Border Radius
  static const double radius4 = 4.0;
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius20 = 20.0;
  static const double radius24 = 24.0;
  static const double radius32 = 32.0;

  // Border Width
  static const double borderWidth1 = 1.0;
  static const double borderWidth2 = 2.0;

  // Icon Sizes
  static const double iconSize16 = 16.0;
  static const double iconSize20 = 20.0;
  static const double iconSize24 = 24.0;
  static const double iconSize28 = 28.0;
  static const double iconSize32 = 32.0;
  static const double iconSize40 = 40.0;
  static const double iconSize48 = 48.0;

  // Font Sizes
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0;
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;
  static const double fontSize36 = 36.0;
  static const double fontSize48 = 48.0;

  // Font Weights
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;

  // Line Heights
  static const double lineHeight1_2 = 1.2;
  static const double lineHeight1_4 = 1.4;
  static const double lineHeight1_5 = 1.5;
  static const double lineHeight1_6 = 1.6;

  // Elevation/Shadows
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation6 = 6.0;
  static const double elevation8 = 8.0;
  static const double elevation12 = 12.0;
  static const double elevation16 = 16.0;
  static const double elevation24 = 24.0;

  // Opacity
  static const double opacity0 = 0.0;
  static const double opacity10 = 0.1;
  static const double opacity20 = 0.2;
  static const double opacity30 = 0.3;
  static const double opacity40 = 0.4;
  static const double opacity50 = 0.5;
  static const double opacity60 = 0.6;
  static const double opacity70 = 0.7;
  static const double opacity80 = 0.8;
  static const double opacity90 = 0.9;
  static const double opacity100 = 1.0;

  // Animation Durations
  static const Duration animationDuration100 = Duration(milliseconds: 100);
  static const Duration animationDuration200 = Duration(milliseconds: 200);
  static const Duration animationDuration300 = Duration(milliseconds: 300);
  static const Duration animationDuration500 = Duration(milliseconds: 500);
  static const Duration animationDuration700 = Duration(milliseconds: 700);
  static const Duration animationDuration1000 = Duration(milliseconds: 1000);

  // Button Heights
  static const double buttonHeight40 = 40.0;
  static const double buttonHeight48 = 48.0;
  static const double buttonHeight56 = 56.0;

  // Image Aspect Ratios
  static const double aspectRatioSquare = 1.0;
  static const double aspectRatio4_3 = 4 / 3;
  static const double aspectRatio16_9 = 16 / 9;

  // App Bar Height
  static const double appBarHeight = 56.0;

  // Screen Padding
  static const EdgeInsets screenPadding = EdgeInsets.all(spacing16);
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(horizontal: spacing16);
  static const EdgeInsets screenPaddingVertical = EdgeInsets.symmetric(vertical: spacing16);

  // Card Padding
  static const EdgeInsets cardPadding = EdgeInsets.all(spacing16);
  static const EdgeInsets cardPaddingSmall = EdgeInsets.all(spacing12);

  // Button Padding
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: spacing32,
    vertical: spacing16,
  );
  static const EdgeInsets buttonPaddingSmall = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing12,
  );

  // List Item Padding
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing12,
  );

  // Dialog Padding
  static const EdgeInsets dialogPadding = EdgeInsets.all(spacing24);
}
