import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/string_constants.dart';
import '../constants/ui_constants.dart';

/// Utility class for common UI operations and calculations
class UiUtils {
  /// Get responsive padding based on screen size
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      // Mobile
      return UiConstants.screenPadding;
    } else if (screenWidth < 1200) {
      // Tablet
      return const EdgeInsets.all(UiConstants.spacing24);
    } else {
      // Desktop
      return const EdgeInsets.all(UiConstants.spacing32);
    }
  }

  /// Get responsive text scale factor
  static double getTextScaleFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 600) {
      return 1.0;
    } else if (screenWidth < 1200) {
      return 1.1;
    } else {
      return 1.2;
    }
  }

  /// Calculate appropriate elevation based on theme
  static double getElevation(BuildContext context, double baseElevation) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? baseElevation * 0.8 : baseElevation;
  }

  /// Get theme-aware shadow color
  static Color getShadowColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? ColorConstants.shadowDark
        : ColorConstants.shadowLight;
  }

  /// Create a consistent box shadow
  static List<BoxShadow> getBoxShadow(BuildContext context, {
    double elevation = UiConstants.elevation4,
    Color? color,
    Offset offset = const Offset(0, 2),
    double blurRadius = 4.0,
  }) {
    final shadowColor = color ?? getShadowColor(context).withValues(alpha: 0.1);
    return [
      BoxShadow(
        color: shadowColor,
        offset: offset,
        blurRadius: blurRadius,
      ),
    ];
  }

  /// Get border radius for different component types
  static BorderRadius getBorderRadius({
    double radius = UiConstants.radius8,
  }) {
    return BorderRadius.circular(radius);
  }

  /// Calculate button size based on type
  static Size getButtonSize({
    double height = UiConstants.buttonHeight48,
    double? width,
  }) {
    return Size(width ?? double.infinity, height);
  }

  /// Get appropriate icon size for different contexts
  static double getIconSize(BuildContext context, {
    double baseSize = UiConstants.iconSize24,
  }) {
    final textScaler = MediaQuery.of(context).textScaler;
    return baseSize * textScaler.scale(1.0).clamp(0.8, 1.2);
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Calculate available content height (excluding app bar and safe area)
  static double getAvailableContentHeight(BuildContext context, {
    bool excludeAppBar = true,
    double appBarHeight = UiConstants.appBarHeight,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
    final safeAreaPadding = getSafeAreaPadding(context);
    final appBarOffset = excludeAppBar ? appBarHeight : 0.0;

    return screenHeight - safeAreaPadding.top - safeAreaPadding.bottom - appBarOffset;
  }

  /// Get keyboard height
  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return getKeyboardHeight(context) > 0;
  }

  /// Show a snackbar with consistent styling
  static void showSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
    Color? backgroundColor,
    Color? textColor,
  }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: textColor ?? ColorConstants.white,
          fontSize: UiConstants.fontSize14,
        ),
      ),
      backgroundColor: backgroundColor ?? ColorConstants.primary,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: getBorderRadius(radius: UiConstants.radius8),
      ),
      margin: const EdgeInsets.all(UiConstants.spacing16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// Hide current snackbar
  static void hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// Show a loading dialog
  static void showLoadingDialog(BuildContext context, {
    String message = StringConstants.loading,
    bool barrierDismissible = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: UiConstants.spacing16),
            Text(message),
          ],
        ),
      ),
    );
  }

  /// Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  /// Get theme-aware surface color with elevation
  static Color getSurfaceColor(BuildContext context, {
    double elevation = 0.0,
  }) {
    final baseColor = ColorConstants.getSurface(context);
    if (elevation == 0.0) return baseColor;

    // Simple elevation color calculation
    final elevationFactor = (elevation / 24.0).clamp(0.0, 1.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return Color.lerp(baseColor, ColorConstants.white, elevationFactor * 0.05)!;
    } else {
      return Color.lerp(baseColor, ColorConstants.black, elevationFactor * 0.02)!;
    }
  }

  /// Format duration for display
  static String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Get appropriate text style for different text types
  static TextStyle getTextStyle({
    required BuildContext context,
    double fontSize = UiConstants.fontSize14,
    FontWeight fontWeight = UiConstants.fontWeightRegular,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? ColorConstants.getTextPrimary(context),
      height: height ?? UiConstants.lineHeight1_5,
    );
  }
}
