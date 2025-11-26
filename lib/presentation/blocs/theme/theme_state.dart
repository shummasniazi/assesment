import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// States for ThemeBloc
abstract class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

/// Initial theme state - uses system theme
class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(ThemeMode.system);
}

/// Light theme state
class ThemeLight extends ThemeState {
  const ThemeLight() : super(ThemeMode.light);
}

/// Dark theme state
class ThemeDark extends ThemeState {
  const ThemeDark() : super(ThemeMode.dark);
}
