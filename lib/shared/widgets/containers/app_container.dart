import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../../core/utils/ui_utils.dart';

/// Custom container component with consistent styling
class AppContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final Alignment? alignment;
  final Decoration? decoration;
  final List<BoxShadow>? boxShadow;
  final double? elevation;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Clip clipBehavior;
  final String? semanticLabel;

  const AppContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.width,
    this.height,
    this.constraints,
    this.alignment,
    this.decoration,
    this.boxShadow,
    this.elevation,
    this.onTap,
    this.onLongPress,
    this.clipBehavior = Clip.none,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration = decoration ?? _buildDecoration(context);
    final effectivePadding = padding ?? ResponsiveConstants.cardPaddingSmall;
    final effectiveMargin = margin ?? EdgeInsets.zero;
    final effectiveBorderRadius = borderRadius ?? ResponsiveConstants.radius8;

    Widget container = Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: effectiveMargin,
      alignment: alignment,
      decoration: effectiveDecoration,
      clipBehavior: clipBehavior,
      child: child != null ? Padding(
        padding: effectivePadding,
        child: child,
      ) : null,
    );

    if (onTap != null || onLongPress != null) {
      container = Semantics(
        container: true,
        label: semanticLabel,
        button: onTap != null,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          child: container,
        ),
      );
    } else if (semanticLabel != null) {
      container = Semantics(
        container: true,
        label: semanticLabel,
        child: container,
      );
    }

    return container;
  }

  Decoration _buildDecoration(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? ColorConstants.getSurface(context);
    final effectiveBorderColor = borderColor ?? ColorConstants.getBorder(context);
    final effectiveBorderWidth = borderWidth ?? ResponsiveConstants.borderWidth1;
    final effectiveBorderRadius = borderRadius ?? ResponsiveConstants.radius8;
    final effectiveBoxShadow = boxShadow ?? (elevation != null ? UiUtils.getBoxShadow(context, elevation: elevation!) : null);

    return BoxDecoration(
      color: effectiveBackgroundColor,
      borderRadius: BorderRadius.circular(effectiveBorderRadius),
      border: Border.all(
        color: effectiveBorderColor,
        width: effectiveBorderWidth,
      ),
      boxShadow: effectiveBoxShadow,
    );
  }

  /// Factory constructor for rounded container
  factory AppContainer.rounded({
    Key? key,
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    double? borderRadius,
    double? width,
    double? height,
    BoxConstraints? constraints,
    Alignment? alignment,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? semanticLabel,
  }) {
    return AppContainer(
      key: key,
      child: child,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius ?? ResponsiveConstants.radius16,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
    );
  }

  /// Factory constructor for bordered container
  factory AppContainer.bordered({
    Key? key,
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? width,
    double? height,
    BoxConstraints? constraints,
    Alignment? alignment,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? semanticLabel,
  }) {
    return AppContainer(
      key: key,
      child: child,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      borderWidth: borderWidth ?? ResponsiveConstants.borderWidth2,
      borderRadius: borderRadius ?? ResponsiveConstants.radius8,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
    );
  }

  /// Factory constructor for elevated container
  factory AppContainer.elevated({
    Key? key,
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? backgroundColor,
    double? borderRadius,
    double? elevation,
    double? width,
    double? height,
    BoxConstraints? constraints,
    Alignment? alignment,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? semanticLabel,
  }) {
    return AppContainer(
      key: key,
      child: child,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius ?? ResponsiveConstants.radius8,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      elevation: elevation ?? ResponsiveConstants.elevation4,
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
    );
  }

  /// Factory constructor for gradient container
  factory AppContainer.gradient({
    Key? key,
    Widget? child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    required Gradient gradient,
    double? borderRadius,
    double? width,
    double? height,
    BoxConstraints? constraints,
    Alignment? alignment,
    VoidCallback? onTap,
    VoidCallback? onLongPress,
    String? semanticLabel,
  }) {
    return AppContainer(
      key: key,
      child: child,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius ?? ResponsiveConstants.radius8,
      width: width,
      height: height,
      constraints: constraints,
      alignment: alignment,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius ?? ResponsiveConstants.radius8),
      ),
      onTap: onTap,
      onLongPress: onLongPress,
      semanticLabel: semanticLabel,
    );
  }
}
