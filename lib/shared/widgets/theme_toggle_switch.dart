import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/color_constants.dart';
import '../../core/constants/responsive_constants.dart';
import '../../core/constants/string_constants.dart';
import '../../presentation/blocs/theme/theme_bloc.dart';
import '../../presentation/blocs/theme/theme_event.dart';
import '../../presentation/blocs/theme/theme_state.dart';

/// Theme toggle switch widget
class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDark = themeState.themeMode == ThemeMode.dark;

        return Semantics(
        label: StringConstants.themeToggle,
        hint: isDark ? StringConstants.switchToLightMode : StringConstants.switchToDarkMode,
          child: Container(
            padding: EdgeInsets.all(ResponsiveConstants.spacing4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(ResponsiveConstants.radius24),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withValues(alpha: 0.1),
                  blurRadius: ResponsiveConstants.elevation4,
                  offset: Offset(0, ResponsiveConstants.spacing2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Light mode icon
                GestureDetector(
                  onTap: () => context.read<ThemeBloc>().add(const SetThemeMode(ThemeMode.light)),
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveConstants.spacing8),
                    decoration: BoxDecoration(
                      color: !isDark ? ColorConstants.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(ResponsiveConstants.radius20),
                    ),
                    child: Icon(
                      Icons.light_mode_rounded,
                      color: !isDark ? Colors.white : ColorConstants.textSecondaryDark,
                      size: ResponsiveConstants.iconSize20,
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveConstants.spacing4),
                // Dark mode icon
                GestureDetector(
                  onTap: () => context.read<ThemeBloc>().add(const SetThemeMode(ThemeMode.dark)),
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveConstants.spacing8),
                    decoration: BoxDecoration(
                      color: isDark ? ColorConstants.secondary : Colors.transparent,
                      borderRadius: BorderRadius.circular(ResponsiveConstants.radius20),
                    ),
                    child: Icon(
                      Icons.dark_mode_rounded,
                      color: isDark ? Colors.white : ColorConstants.textSecondaryLight,
                      size: ResponsiveConstants.iconSize20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
