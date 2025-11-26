import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../../core/utils/ui_utils.dart';

/// Custom card component with consistent styling
class AppCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? elevation;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ShapeBorder? shape;
  final Clip clipBehavior;
  final bool semanticContainer;
  final String? semanticLabel;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
    this.onTap,
    this.onLongPress,
    this.shape,
    this.clipBehavior = Clip.none,
    this.semanticContainer = true,
    this.semanticLabel,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? ColorConstants.getSurface(context);
    final effectiveBorderColor = borderColor ?? ColorConstants.getBorder(context);
    final defaultElevation = elevation ?? ResponsiveConstants.elevation2;
    final effectiveElevation = UiUtils.getElevation(context, defaultElevation);
    final effectivePadding = padding ?? ResponsiveConstants.cardPadding;
    final effectiveMargin = margin ?? EdgeInsets.zero;
    final effectiveBorderRadius = borderRadius ?? ResponsiveConstants.radius12;

    final card = Container(
      width: width,
      height: height,
      margin: effectiveMargin,
      child: Card(
        color: effectiveBackgroundColor,
        elevation: effectiveElevation,
        shadowColor: UiUtils.getShadowColor(context),
        shape: shape ?? RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          side: BorderSide(
            color: effectiveBorderColor,
            width: borderWidth ?? ResponsiveConstants.borderWidth1,
          ),
        ),
        clipBehavior: clipBehavior,
        semanticContainer: semanticContainer,
        child: Semantics(
          container: true,
          label: semanticLabel,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: BorderRadius.circular(effectiveBorderRadius),
            child: Padding(
              padding: effectivePadding,
              child: child,
            ),
          ),
        ),
      ),
    );

    return card;
  }

  /// Factory constructor for elevated card
  factory AppCard.elevated({
    Key? key,
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    double? borderRadius,
    double? elevation,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? semanticLabel,
    double? width,
    double? height,
  }) {
    return AppCard(
      key: key,
      child: child,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      elevation: elevation,
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
      width: width,
      height: height,
    );
  }

  /// Factory constructor for outlined card
  factory AppCard.outlined({
    Key? key,
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? semanticLabel,
    double? width,
    double? height,
  }) {
    return AppCard(
      key: key,
      child: child,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderColor: borderColor ?? ColorConstants.borderLight,
      borderWidth: ResponsiveConstants.borderWidth2,
      borderRadius: borderRadius,
      elevation: 0,
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
      width: width,
      height: height,
    );
  }

  /// Factory constructor for filled card
  factory AppCard.filled({
    Key? key,
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    double? borderRadius,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? semanticLabel,
    double? width,
    double? height,
  }) {
    return AppCard(
      key: key,
      child: child,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderWidth: 0,
      borderRadius: borderRadius,
      elevation: 0,
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
      width: width,
      height: height,
    );
  }
}
