import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Responsive constants that scale with screen size
class ResponsiveConstants {
  // Responsive Spacing - scales with screen width
  static double get spacing2 => 2.w;
  static double get spacing4 => 4.w;
  static double get spacing8 => 8.w;
  static double get spacing12 => 12.w;
  static double get spacing16 => 16.w;
  static double get spacing20 => 20.w;
  static double get spacing24 => 24.w;
  static double get spacing32 => 32.w;
  static double get spacing40 => 40.w;
  static double get spacing48 => 48.w;
  static double get spacing56 => 56.w;
  static double get spacing64 => 64.w;

  // Responsive Border Radius - scales with screen width
  static double get radius4 => 4.r;
  static double get radius8 => 8.r;
  static double get radius12 => 12.r;
  static double get radius16 => 16.r;
  static double get radius20 => 20.r;
  static double get radius24 => 24.r;
  static double get radius32 => 32.r;

  // Border Width - stays constant
  static const double borderWidth1 = 1.0;
  static const double borderWidth2 = 2.0;

  // Responsive Icon Sizes - scales with screen width
  static double get iconSize16 => 16.w;
  static double get iconSize20 => 20.w;
  static double get iconSize24 => 24.w;
  static double get iconSize28 => 28.w;
  static double get iconSize32 => 32.w;
  static double get iconSize40 => 40.w;
  static double get iconSize48 => 48.w;

  // Responsive Font Sizes - scales with screen width
  static double get fontSize10 => 10.sp;
  static double get fontSize12 => 12.sp;
  static double get fontSize14 => 14.sp;
  static double get fontSize16 => 16.sp;
  static double get fontSize18 => 18.sp;
  static double get fontSize20 => 20.sp;
  static double get fontSize24 => 24.sp;
  static double get fontSize28 => 28.sp;
  static double get fontSize32 => 32.sp;
  static double get fontSize36 => 36.sp;
  static double get fontSize48 => 48.sp;

  // Font Weights - constants
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;

  // Line Heights - constants
  static const double lineHeight1_2 = 1.2;
  static const double lineHeight1_4 = 1.4;
  static const double lineHeight1_5 = 1.5;
  static const double lineHeight1_6 = 1.6;

  // Elevation - constants
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation6 = 6.0;
  static const double elevation8 = 8.0;
  static const double elevation12 = 12.0;
  static const double elevation16 = 16.0;
  static const double elevation24 = 24.0;

  // Opacity - constants
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

  // Animation Durations - constants
  static const Duration animationDuration100 = Duration(milliseconds: 100);
  static const Duration animationDuration200 = Duration(milliseconds: 200);
  static const Duration animationDuration300 = Duration(milliseconds: 300);
  static const Duration animationDuration500 = Duration(milliseconds: 500);
  static const Duration animationDuration700 = Duration(milliseconds: 700);
  static const Duration animationDuration1000 = Duration(milliseconds: 1000);

  // Responsive Button Heights - scales with screen height
  static double get buttonHeight40 => 40.h;
  static double get buttonHeight48 => 48.h;
  static double get buttonHeight56 => 56.h;

  // Responsive Aspect Ratios - constants
  static const double aspectRatioSquare = 1.0;
  static const double aspectRatio4_3 = 4 / 3;
  static const double aspectRatio16_9 = 16 / 9;

  // Responsive App Bar Height - scales with screen height
  static double get appBarHeight => 56.h;

  // Responsive Screen Padding - scales with screen width
  static EdgeInsets get screenPadding => EdgeInsets.all(spacing16);
  static EdgeInsets get screenPaddingHorizontal => EdgeInsets.symmetric(horizontal: spacing16);
  static EdgeInsets get screenPaddingVertical => EdgeInsets.symmetric(vertical: spacing16);

  // Responsive Card Padding - scales with screen width
  static EdgeInsets get cardPadding => EdgeInsets.all(spacing16);
  static EdgeInsets get cardPaddingSmall => EdgeInsets.all(spacing12);

  // Responsive Button Padding - scales with screen width
  static EdgeInsets get buttonPadding => EdgeInsets.symmetric(
        horizontal: spacing32,
        vertical: spacing16,
      );
  static EdgeInsets get buttonPaddingSmall => EdgeInsets.symmetric(
        horizontal: spacing16,
        vertical: spacing12,
      );

  // Responsive List Item Padding - scales with screen width
  static EdgeInsets get listItemPadding => EdgeInsets.symmetric(
        horizontal: spacing16,
        vertical: spacing12,
      );

  // Responsive Dialog Padding - scales with screen width
  static EdgeInsets get dialogPadding => EdgeInsets.all(spacing24);
}
