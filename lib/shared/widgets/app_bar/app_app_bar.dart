import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/utils/ui_utils.dart';

/// Custom app bar with consistent styling
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final double elevation;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final Brightness? statusBarBrightness;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final double? toolbarHeight;
  final ShapeBorder? shape;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final TextStyle? titleTextStyle;
  final bool primary;
  final bool excludeHeaderSemantics;
  final double? titleSpacing;
  final double? leadingWidth;
  final String? semanticLabel;

  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = true,
    this.elevation = ResponsiveConstants.elevation4,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.statusBarBrightness,
    this.systemOverlayStyle,
    this.toolbarHeight,
    this.shape,
    this.iconTheme,
    this.actionsIconTheme,
    this.titleTextStyle,
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.leadingWidth,
    this.semanticLabel,
  }) : assert(title != null || titleWidget != null, 'Either title or titleWidget must be provided');

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? ColorConstants.getSurface(context);
    final effectiveForegroundColor = foregroundColor ?? ColorConstants.getTextPrimary(context);
    final effectiveElevation = UiUtils.getElevation(context, elevation);

    return Semantics(
      container: true,
      label: semanticLabel ?? (title ?? StringConstants.appBar),
      child: AppBar(
        title: titleWidget ?? _buildTitle(context, effectiveForegroundColor),
        leading: leading,
        actions: actions,
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: effectiveForegroundColor,
        centerTitle: centerTitle,
        elevation: effectiveElevation,
        automaticallyImplyLeading: automaticallyImplyLeading,
        bottom: bottom,
        shadowColor: UiUtils.getShadowColor(context),
        surfaceTintColor: effectiveBackgroundColor,
        systemOverlayStyle: systemOverlayStyle ?? _getSystemOverlayStyle(context, effectiveBackgroundColor),
        toolbarHeight: toolbarHeight,
        shape: shape,
        iconTheme: iconTheme ?? IconThemeData(
          color: effectiveForegroundColor,
          size: ResponsiveConstants.iconSize24,
        ),
        actionsIconTheme: actionsIconTheme ?? IconThemeData(
          color: effectiveForegroundColor,
          size: ResponsiveConstants.iconSize24,
        ),
        titleTextStyle: titleTextStyle ?? _getTitleTextStyle(effectiveForegroundColor),
        primary: primary,
        excludeHeaderSemantics: excludeHeaderSemantics,
        titleSpacing: titleSpacing ?? NavigationToolbar.kMiddleSpacing,
        leadingWidth: leadingWidth,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, Color foregroundColor) {
    if (title == null) return const SizedBox.shrink();

    return Text(
      title!,
      style: _getTitleTextStyle(foregroundColor),
    );
  }

  TextStyle _getTitleTextStyle(Color foregroundColor) {
    return TextStyle(
      color: foregroundColor,
      fontSize: ResponsiveConstants.fontSize20,
      fontWeight: ResponsiveConstants.fontWeightSemiBold,
      height: ResponsiveConstants.lineHeight1_2,
    );
  }

  SystemUiOverlayStyle _getSystemOverlayStyle(BuildContext context, Color backgroundColor) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLightBackground = backgroundColor.computeLuminance() > 0.5;

    if (isDark) {
      return SystemUiOverlayStyle.light.copyWith(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      );
    } else {
      return SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: backgroundColor,
        statusBarIconBrightness: isLightBackground ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: backgroundColor,
        systemNavigationBarIconBrightness: isLightBackground ? Brightness.dark : Brightness.light,
      );
    }
  }

  @override
  Size get preferredSize => Size.fromHeight(
    toolbarHeight ?? ResponsiveConstants.appBarHeight + (bottom?.preferredSize.height ?? 0),
  );

  /// Factory constructor for simple app bar with title
  factory AppAppBar.simple({
    Key? key,
    required String title,
    Widget? leading,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? foregroundColor,
    bool centerTitle = true,
    double elevation = ResponsiveConstants.elevation4,
    PreferredSizeWidget? bottom,
    String? semanticLabel,
  }) {
    return AppAppBar(
      key: key,
      title: title,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      centerTitle: centerTitle,
      elevation: elevation,
      bottom: bottom,
      semanticLabel: semanticLabel,
    );
  }

  /// Factory constructor for app bar with custom title widget
  factory AppAppBar.custom({
    Key? key,
    required Widget titleWidget,
    Widget? leading,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? foregroundColor,
    bool centerTitle = true,
    double elevation = ResponsiveConstants.elevation4,
    PreferredSizeWidget? bottom,
    String? semanticLabel,
  }) {
    return AppAppBar(
      key: key,
      titleWidget: titleWidget,
      leading: leading,
      actions: actions,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      centerTitle: centerTitle,
      elevation: elevation,
      bottom: bottom,
      semanticLabel: semanticLabel,
    );
  }

  /// Factory constructor for transparent app bar
  factory AppAppBar.transparent({
    Key? key,
    String? title,
    Widget? titleWidget,
    Widget? leading,
    List<Widget>? actions,
    bool centerTitle = true,
    PreferredSizeWidget? bottom,
    String? semanticLabel,
  }) {
    return AppAppBar(
      key: key,
      title: title,
      titleWidget: titleWidget,
      leading: leading,
      actions: actions,
      backgroundColor: ColorConstants.transparent,
      foregroundColor: ColorConstants.white,
      centerTitle: centerTitle,
      elevation: 0,
      bottom: bottom,
      semanticLabel: semanticLabel,
    );
  }
}
