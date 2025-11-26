import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'theme_event.dart';
import 'theme_state.dart';

/// BLoC for managing theme state
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial()) {
    on<ToggleTheme>(_onToggleTheme);
    on<SetThemeMode>(_onSetThemeMode);
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    if (state.themeMode == ThemeMode.light) {
      emit(const ThemeDark());
    } else {
      emit(const ThemeLight());
    }
  }

  void _onSetThemeMode(SetThemeMode event, Emitter<ThemeState> emit) {
    switch (event.themeMode) {
      case ThemeMode.light:
        emit(const ThemeLight());
        break;
      case ThemeMode.dark:
        emit(const ThemeDark());
        break;
      case ThemeMode.system:
        emit(const ThemeInitial());
        break;
    }
  }
}
