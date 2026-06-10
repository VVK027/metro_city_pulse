import 'package:flutter/widgets.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';

/// A cached snapshot of the current responsive layout so widgets can avoid
/// calling `Responsive.isMobile(context)` / `MediaQuery.of(context)` multiple
/// times in the same `build`. Each call to those methods registers an
/// InheritedWidget dependency and can subscribe the widget to redundant
/// rebuilds when unrelated MediaQuery fields change.
///
/// Usage:
///   final layout = AppResponsiveScope.of(context);
///   if (layout.isMobile) { ... }
@immutable
class AppResponsive {
  final Size size;
  final bool isMobile;
  final bool isSmallerTablet;
  final bool isTablet;
  final bool isDesktop;

  const AppResponsive({
    required this.size,
    required this.isMobile,
    required this.isSmallerTablet,
    required this.isTablet,
    required this.isDesktop,
  });

  bool get isMobileOrSmallerTablet => isMobile || isSmallerTablet;

  factory AppResponsive.fromContext(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final double w = size.width;
    final bool isMobile = w <= mobileWidth;
    final bool isSmallerTablet = w >= mobileWidth && w < tabletWidth;
    final bool isTablet = w >= mobileWidth && w < desktopWidth;
    final bool isDesktop = w >= desktopWidth;
    return AppResponsive(
      size: size,
      isMobile: isMobile,
      isSmallerTablet: isSmallerTablet,
      isTablet: isTablet,
      isDesktop: isDesktop,
    );
  }
}
