import 'package:flutter/material.dart';

final int desktopWidth = 1024; //1100
final int tabletWidth = 768; //850
final int mobileWidth = 600; //600 px accommodate larger phones or landscape && 480px is mobile devices (smartphones)
final int mobileLowestWidth = 320; // common minimum width smartphones

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // Use MediaQuery.sizeOf so widgets only depend on the size sub-aspect of
  // MediaQuery, not the entire MediaQueryData. This avoids rebuilds when
  // unrelated MediaQuery fields (padding, viewInsets, etc.) change.
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width <= mobileWidth;

  static bool isSmallerTablet(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    return w >= mobileWidth && w < tabletWidth;
  }

  static bool isTablet(BuildContext context) {
    final double w = MediaQuery.sizeOf(context).width;
    return w >= mobileWidth && w < desktopWidth;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopWidth;


  @override
  Widget build(BuildContext context) {
    if (isDesktop(context)) {
      return desktop;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return mobile;
    }
  }
}

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= desktopWidth) {
          return desktop;
        } else if (constraints.maxWidth >= tabletWidth) {
          return tablet;
        } else {
          return mobile;
        }
      },
    );
  }
}