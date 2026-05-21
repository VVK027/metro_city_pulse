import 'package:metro_city_pulse/core/themes/app_assets.dart';
import 'package:metro_city_pulse/core/themes/app_colors.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/core/themes/app_theme_mode.dart';
import 'package:metro_city_pulse/core/themes/dark/app_dark_colors.dart';
import 'package:flutter/material.dart';

class AppThemeDark extends AppTheme {
  @override
  AppThemeMode get mode => AppThemeMode.dark;

  @override
  AppColors get colors => AppDarkColors();

  @override
  AppAssets get assets => AppAssets();

  @override
  ThemeData get themeData => ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: colors.primary,
    scaffoldBackgroundColor: colors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.primaryColor,
      primary: colors.primaryColor,
      secondary: colors.accent,
      surface: colors.surface,
      onSurface: colors.text,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colors.appBarBackgroundColor,
      foregroundColor: colors.white,
      surfaceTintColor: colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: colors.white),
      actionsIconTheme: IconThemeData(color: colors.white),
    ),
    cardTheme: CardThemeData(
      color: colors.surface,
      surfaceTintColor: colors.transparent,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colors.surface,
      surfaceTintColor: colors.transparent,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: colors.surface,
      surfaceTintColor: colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF2C2F36),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.lightGray.withValues(alpha: 0.3)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.lightGray.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.primaryColor),
      ),
      hintStyle: TextStyle(color: colors.text.withValues(alpha: 0.5)),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2C2F36),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: colors.lightGray.withValues(alpha: 0.3),
      thickness: 0.5,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: colors.primaryColor,
      inactiveTrackColor: colors.lightGray.withValues(alpha: 0.3),
      thumbColor: colors.primaryColor,
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
    listTileTheme: ListTileThemeData(
      textColor: colors.text,
      iconColor: colors.text,
    ),
    iconTheme: IconThemeData(color: colors.text),
    chipTheme: ChipThemeData(
      backgroundColor: colors.surface,
      selectedColor: colors.primaryColor.withValues(alpha: 0.2),
      labelStyle: TextStyle(color: colors.text),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? colors.primaryColor
            : colors.lightGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        return states.contains(WidgetState.selected)
            ? colors.primaryColor.withValues(alpha: 0.4)
            : colors.lightGray.withValues(alpha: 0.3);
      }),
    ),
  );
}
