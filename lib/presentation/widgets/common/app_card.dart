import 'package:flutter/material.dart';
import 'package:metro_city_pulse/core/constants/constants.dart';

/// A reusable card with the project-wide rounded shape, elevation and clip
/// behavior. Replaces the repeated
/// `Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: defaultCardElevation, clipBehavior: Clip.antiAlias, child: ...)`
/// pattern that appears in many screens (map section, recent alerts, summary
/// card, side panel, etc.).
class AppCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double borderRadius;
  final double elevation;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.borderRadius = 16,
    this.elevation = defaultCardElevation,
    this.clipBehavior = Clip.antiAlias,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final Widget content = padding == null
        ? child
        : Padding(padding: padding!, child: child);

    return Card(
      color: color,
      margin: margin ?? EdgeInsets.zero,
      elevation: elevation,
      clipBehavior: clipBehavior,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: content,
    );
  }
}
