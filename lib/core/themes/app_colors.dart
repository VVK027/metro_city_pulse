import 'package:flutter/material.dart';

abstract class AppColors {
  Color get primary;
  Color get background;
  Color get surface;
  Color get text;
  Color get accent;

  Color get primaryColor;
  Color get secondaryColor;
  Color get bgColor;
  Color get colorCC2F5D;
  Color get color7A399C;
  Color get white;

  final Color transparent = const Color(0x00000000);
  final Color black = const Color(0xFF000000);
  final Color defaultBlueColor = const Color(0xFF4671C6);

  final Color darkBlue = const Color(0xFF3762CC);
  final Color lightBlue = const Color(0xFFA4C9FF);
  final Color blue = const Color(0xFF4671C6);
  Color get lightGray => const Color(0xFFB3B3B3);
  Color get gray => const Color(0xFF666666);
  Color get darkGray => const Color(0xFF333333);

  Color get backgroundColor => const Color(0xFFE0EBFC);

  final Color gradientColor1 = const Color(0xFF4671C6);
  final Color gradientColor2 = const Color(0xFF3762CC);

  final Color selectedColor = const Color(0xFF3762CC);
  final Color unSelectedColor = const Color(0xFFA4C9FF);

  Color get appBarBackgroundColor => const Color(0xFF4671C6);

  final Color tempGradientColor1 = const Color(0xFFA4C9FF);
  final Color tempGradientColor2 = const Color(0xFF4671C6);
}

