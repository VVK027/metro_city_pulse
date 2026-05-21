import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';

class AppElevatedIconButton extends StatelessWidget {

  final IconData? icon;
  final String label;
  final Color? backgroundColor;
  final Color foregroundColor;
  final double? elevation;

  final double radius;
  final Function()? onPressed;
  final EdgeInsetsGeometry? padding;

  const AppElevatedIconButton({super.key,
    this.icon,
    required this.label,
    this.backgroundColor,
    required this.foregroundColor,
    this.elevation,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    this.radius = 16.0
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon:  Icon(icon, color: foregroundColor),
      label: AppText(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: elevation,
        side: BorderSide(color: foregroundColor),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
