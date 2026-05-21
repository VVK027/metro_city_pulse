import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/core/themes/app_theme_mode.dart';
import 'package:metro_city_pulse/core/themes/dark/app_theme_dark.dart';
import 'package:metro_city_pulse/core/themes/light/app_theme_light.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_theme_provider.g.dart';


@riverpod
class AppThemeState extends _$AppThemeState {

  AppThemeMode _themeMode = AppThemeMode.light;

  AppThemeMode get currentMode => _themeMode;

  @override
  AppTheme build() {
    _setupSystemThemeListener();
    return _themeMode == AppThemeMode.dark ? AppThemeDark(): AppThemeLight();
  }

  void toggle(bool isDarkMode) {
    _themeMode = isDarkMode ? AppThemeMode.dark : AppThemeMode.light;
    state =  isDarkMode ?  AppThemeDark() : AppThemeLight();
  }

  void _setupSystemThemeListener() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.dark) {
        _themeMode = AppThemeMode.dark;
      } else {
        _themeMode = AppThemeMode.light;
      }
      state =  _themeMode == AppThemeMode.dark ?  AppThemeDark() : AppThemeLight();
    };
  }
}