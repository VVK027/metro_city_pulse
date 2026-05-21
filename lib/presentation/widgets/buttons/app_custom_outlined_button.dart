import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';

class AppCustomOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? labelIcon;
  final String? label;
  final double iconSize;
  final double? gap;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;

  const AppCustomOutlinedButton({
    super.key,
    required this.onPressed,
    this.icon,
    this.labelIcon,
    this.label,
    this.iconSize = 18.0,
    this.gap,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    final defaultBorderColor = Theme.of(context).colorScheme.outline.withValues(alpha: 0.4);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: padding,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor ?? defaultBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon, size: iconSize, color: foregroundColor),

          if (icon != null && (label != null || labelIcon != null))
            SizedBox(width: gap ?? 4),

          if (label != null)
            AppText(label ?? '', color: foregroundColor),

          if (label != null && labelIcon != null)
            SizedBox(width: gap ?? 4),

          if (labelIcon != null)
            Icon(labelIcon, size: iconSize, color: foregroundColor),
        ],
      ),
    );
  }
}
