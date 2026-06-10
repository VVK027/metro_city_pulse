import 'package:flutter/material.dart';

/// A small reusable loading indicator. Avoids re-creating
/// `Center(child: CircularProgressIndicator())` in every screen and gives us
/// a single place to swap in a branded loader later if needed.
class AppLoading extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color? color;

  const AppLoading({
    super.key,
    this.size = 28,
    this.strokeWidth = 2.6,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
          valueColor: color == null ? null : AlwaysStoppedAnimation<Color>(color!),
        ),
      ),
    );
  }
}
