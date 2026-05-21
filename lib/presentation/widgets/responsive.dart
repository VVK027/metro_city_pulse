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

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= mobileWidth;

  // static bool isTablet(BuildContext context) =>
  //     MediaQuery.of(context).size.width < desktopWidth &&
  //     MediaQuery.of(context).size.width >= tabletWidth;


  static bool isSmallerTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth && MediaQuery.of(context).size.width < tabletWidth;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth && MediaQuery.of(context).size.width < desktopWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= desktopWidth;


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