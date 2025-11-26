import 'package:flutter/material.dart';

/// Events for ThemeBloc
abstract class ThemeEvent {
  const ThemeEvent();
}

/// Event to toggle between light and dark theme
class ToggleTheme extends ThemeEvent {
  const ToggleTheme();
}

/// Event to set theme mode explicitly
class SetThemeMode extends ThemeEvent {
  final ThemeMode themeMode;

  const SetThemeMode(this.themeMode);
}
