import 'package:flutter/material.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/responsive_constants.dart';
import '../../../core/constants/string_constants.dart';
import '../../../core/utils/ui_utils.dart';

/// Different button variants
enum AppButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  danger,
}

/// Different button sizes
enum AppButtonSize {
  small,
  medium,
  large,
}

/// Custom button component with consistent styling
class AppButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? elevation;
  final String? semanticLabel;
  final String? tooltip;

  const AppButton({
    super.key,
    this.text,
    this.child,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.elevation,
    this.semanticLabel,
    this.tooltip,
  }) : assert(text != null || child != null, 'Either text or child must be provided');

  /// Factory constructor for primary button
  factory AppButton.primary({
    Key? key,
    String? text,
    Widget? child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    double? height,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? semanticLabel,
    String? tooltip,
  }) {
    return AppButton(
      key: key,
      text: text,
      child: child,
      onPressed: onPressed,
      variant: AppButtonVariant.primary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      height: height,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      semanticLabel: semanticLabel,
      tooltip: tooltip,
    );
  }

  /// Factory constructor for secondary button
  factory AppButton.secondary({
    Key? key,
    String? text,
    Widget? child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    double? height,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? semanticLabel,
    String? tooltip,
  }) {
    return AppButton(
      key: key,
      text: text,
      child: child,
      onPressed: onPressed,
      variant: AppButtonVariant.secondary,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      height: height,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      semanticLabel: semanticLabel,
      tooltip: tooltip,
    );
  }

  /// Factory constructor for outline button
  factory AppButton.outline({
    Key? key,
    String? text,
    Widget? child,
    VoidCallback? onPressed,
    AppButtonSize size = AppButtonSize.medium,
    bool isLoading = false,
    bool isDisabled = false,
    double? width,
    double? height,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? semanticLabel,
    String? tooltip,
  }) {
    return AppButton(
      key: key,
      text: text,
      child: child,
      onPressed: onPressed,
      variant: AppButtonVariant.outline,
      size: size,
      isLoading: isLoading,
      isDisabled: isDisabled,
      width: width,
      height: height,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      semanticLabel: semanticLabel,
      tooltip: tooltip,
    );
  }

  /// Factory constructor for loading button
  factory AppButton.loading({
    Key? key,
    String? text,
    Widget? child,
    VoidCallback? onPressed,
    AppButtonVariant variant = AppButtonVariant.primary,
    AppButtonSize size = AppButtonSize.medium,
    bool isDisabled = false,
    double? width,
    double? height,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? semanticLabel,
    String? tooltip,
  }) {
    return AppButton(
      key: key,
      text: text,
      child: child,
      onPressed: onPressed,
      variant: variant,
      size: size,
      isLoading: true,
      isDisabled: isDisabled,
      width: width,
      height: height,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      semanticLabel: semanticLabel,
      tooltip: tooltip,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = (isDisabled || isLoading) ? null : onPressed;

    return Semantics(
      button: true,
      enabled: effectiveOnPressed != null,
      label: semanticLabel ?? (text ?? StringConstants.button),
      child: Tooltip(
        message: tooltip ?? '',
        child: SizedBox(
          width: width,
          height: height ?? _getButtonHeight(),
          child: ElevatedButton(
            onPressed: effectiveOnPressed,
            style: _getButtonStyle(context),
            child: _buildContent(context),
          ),
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    final baseStyle = ElevatedButton.styleFrom(
      padding: padding ?? _getButtonPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? UiUtils.getBorderRadius(radius: _getBorderRadius()),
      ),
      elevation: elevation ?? _getElevation(),
      backgroundColor: _getBackgroundColor(context),
      foregroundColor: _getForegroundColor(context),
      shadowColor: UiUtils.getShadowColor(context),
      side: _getBorderSide(context),
    );

    // Apply disabled state styling
    if (isDisabled) {
      return baseStyle.copyWith(
        backgroundColor: WidgetStateProperty.all(
          ColorConstants.grey400.withValues(alpha: 0.5),
        ),
        foregroundColor: WidgetStateProperty.all(
          ColorConstants.grey600.withValues(alpha: 0.5),
        ),
        elevation: WidgetStateProperty.all(0),
      );
    }

    return baseStyle;
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: _getLoadingSize(),
            height: _getLoadingSize(),
            child: CircularProgressIndicator(
              strokeWidth: ResponsiveConstants.borderWidth2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getForegroundColor(context),
              ),
            ),
          ),
          if (text != null || child != null) ...[
            SizedBox(width: ResponsiveConstants.spacing8),
            _buildTextContent(context),
          ],
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          prefixIcon!,
          SizedBox(width: ResponsiveConstants.spacing8),
        ],
        _buildTextContent(context),
        if (suffixIcon != null) ...[
          SizedBox(width: ResponsiveConstants.spacing8),
          suffixIcon!,
        ],
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    if (child != null) {
      return child!;
    }

    if (text != null) {
      return Text(
        text!,
        style: _getTextStyle(context),
        textAlign: TextAlign.center,
      );
    }

    return const SizedBox.shrink();
  }

  double _getButtonHeight() {
    switch (size) {
      case AppButtonSize.small:
        return ResponsiveConstants.buttonHeight40;
      case AppButtonSize.medium:
        return ResponsiveConstants.buttonHeight48;
      case AppButtonSize.large:
        return ResponsiveConstants.buttonHeight56;
    }
  }

  EdgeInsets _getButtonPadding() {
    switch (size) {
      case AppButtonSize.small:
        return ResponsiveConstants.buttonPaddingSmall;
      case AppButtonSize.medium:
      case AppButtonSize.large:
        return ResponsiveConstants.buttonPadding;
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return ResponsiveConstants.radius8;
      case AppButtonSize.medium:
        return ResponsiveConstants.radius12;
      case AppButtonSize.large:
        return ResponsiveConstants.radius16;
    }
  }

  double _getElevation() {
    if (variant == AppButtonVariant.outline || variant == AppButtonVariant.ghost) {
      return 0;
    }

    switch (size) {
      case AppButtonSize.small:
        return ResponsiveConstants.elevation2;
      case AppButtonSize.medium:
        return ResponsiveConstants.elevation4;
      case AppButtonSize.large:
        return ResponsiveConstants.elevation6;
    }
  }

  double _getLoadingSize() {
    switch (size) {
      case AppButtonSize.small:
        return ResponsiveConstants.iconSize16;
      case AppButtonSize.medium:
        return ResponsiveConstants.iconSize20;
      case AppButtonSize.large:
        return ResponsiveConstants.iconSize24;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    if (backgroundColor != null) return backgroundColor!;

    final theme = Theme.of(context);
    switch (variant) {
      case AppButtonVariant.primary:
        return theme.colorScheme.primary;
      case AppButtonVariant.secondary:
        return theme.colorScheme.secondary;
      case AppButtonVariant.outline:
      case AppButtonVariant.ghost:
        return Colors.transparent;
      case AppButtonVariant.danger:
        return theme.colorScheme.error;
    }
  }

  Color _getForegroundColor(BuildContext context) {
    if (foregroundColor != null) return foregroundColor!;

    final theme = Theme.of(context);
    switch (variant) {
      case AppButtonVariant.primary:
        return theme.colorScheme.onPrimary;
      case AppButtonVariant.secondary:
        return theme.colorScheme.onSecondary;
      case AppButtonVariant.outline:
        return theme.colorScheme.primary;
      case AppButtonVariant.ghost:
        return theme.colorScheme.onSurface;
      case AppButtonVariant.danger:
        return theme.colorScheme.onError;
    }
  }

  BorderSide? _getBorderSide(BuildContext context) {
    if (borderColor != null) {
      return BorderSide(color: borderColor!, width: ResponsiveConstants.borderWidth1);
    }

    final theme = Theme.of(context);
    if (variant == AppButtonVariant.outline) {
      return BorderSide(
        color: theme.colorScheme.primary,
        width: ResponsiveConstants.borderWidth1,
      );
    }

    return null;
  }

  TextStyle _getTextStyle(BuildContext context) {
    final baseSize = _getFontSize();
    final fontWeight = _getFontWeight();

    return UiUtils.getTextStyle(
      context: context,
      fontSize: baseSize,
      fontWeight: fontWeight,
      color: _getForegroundColor(context),
    );
  }

  double _getFontSize() {
    switch (size) {
      case AppButtonSize.small:
        return ResponsiveConstants.fontSize14;
      case AppButtonSize.medium:
        return ResponsiveConstants.fontSize16;
      case AppButtonSize.large:
        return ResponsiveConstants.fontSize18;
    }
  }

  FontWeight _getFontWeight() {
    switch (size) {
      case AppButtonSize.small:
      case AppButtonSize.medium:
        return ResponsiveConstants.fontWeightMedium;
      case AppButtonSize.large:
        return ResponsiveConstants.fontWeightSemiBold;
    }
  }
}
