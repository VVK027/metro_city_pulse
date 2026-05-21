import 'package:flutter/material.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';

/// A reusable empty/info state used for "no data", "feature coming soon" and
/// similar placeholders. Centralizes spacing and typography so screens stay
/// consistent without repeating the same Column-of-Icon+Text everywhere
/// (map section, recent alerts, error states, etc.).
class AppEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final double iconSize;
  final Color? iconColor;
  final Color? textColor;
  final double textSize;
  final EdgeInsetsGeometry padding;

  const AppEmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.iconSize = 64,
    this.iconColor,
    this.textColor,
    this.textSize = 18,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedIconColor = iconColor ?? Colors.grey;
    final Color resolvedTextColor = textColor ?? Colors.grey.shade600;
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: resolvedIconColor),
          const SizedBox(height: 10),
          AppText(
            message,
            size: textSize,
            color: resolvedTextColor,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
