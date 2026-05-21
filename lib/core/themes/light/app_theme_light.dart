import 'package:metro_city_pulse/core/themes/app_assets.dart';
import 'package:metro_city_pulse/core/themes/app_colors.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/core/themes/app_theme_mode.dart';
import 'package:metro_city_pulse/core/themes/light/app_light_colors.dart';
import 'package:flutter/material.dart';

class AppThemeLight extends AppTheme {
  @override
  AppThemeMode get mode => AppThemeMode.light;

  @override
  AppColors get colors => AppLightColors();

  @override
  AppAssets get assets => AppAssets();

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: colors.primary,
    scaffoldBackgroundColor: colors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.primaryColor,
      primary: colors.primaryColor,
      secondary: colors.accent,
      surface: colors.surface,
      brightness: Brightness.light,
    ),
    iconTheme: IconThemeData(color: colors.primary),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.appBarBackgroundColor,
      foregroundColor: colors.white,
      surfaceTintColor: colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: colors.white),
      actionsIconTheme: IconThemeData(color: colors.white),
    ),
    drawerTheme: DrawerThemeData(backgroundColor: colors.surface),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colors.surface,
      indicatorColor: colors.accent,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? colors.primaryColor
              : colors.unSelectedColor,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        return TextStyle(
          color: states.contains(WidgetState.selected)
              ? colors.primaryColor
              : colors.unSelectedColor,
        );
      }),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.surface,
      selectedItemColor: colors.selectedColor,
      unselectedItemColor: colors.unSelectedColor,
      selectedIconTheme: IconThemeData(color: colors.selectedColor),
      unselectedIconTheme: IconThemeData(color: colors.unSelectedColor),
      showUnselectedLabels: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primaryColor,
        foregroundColor: colors.white,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.primaryColor,
        side: BorderSide(color: colors.primaryColor),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: colors.primaryColor),
    ),
  );
}
