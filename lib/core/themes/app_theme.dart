import 'package:metro_city_pulse/core/themes/app_assets.dart';
import 'package:metro_city_pulse/core/themes/app_colors.dart';
import 'package:metro_city_pulse/core/themes/app_theme_mode.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {

  ThemeData get themeData;

  AppColors get colors;

  AppAssets get assets;

  AppThemeMode get mode;

}