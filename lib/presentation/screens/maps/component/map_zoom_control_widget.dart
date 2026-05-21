import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';

class MapZoomControlWidget extends StatelessWidget {
  final VoidCallback? onLocationPressed;
  final VoidCallback? onZoomInPressed;
  final VoidCallback? onZoomOutPressed;
  final VoidCallback? onResetPressed;
  final VoidCallback? onExclamationPressed;

  const MapZoomControlWidget({
    super.key,
    required this.theme,
    this.onLocationPressed,
    this.onZoomInPressed,
    this.onZoomOutPressed,
    this.onResetPressed,
    this.onExclamationPressed,
  });

  final AppTheme theme;

  @override
  Widget build(BuildContext context) {
    double iconSize = 24.0;

    return Column(
      children: [
        if(Responsive.isMobile(context))
          FloatingActionButton(
            mini: true,
            backgroundColor: theme.colors.surface,
            heroTag: "exclamation_all",
            onPressed: onExclamationPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: AppImage(
              theme.assets.exclamationIcon,
              width: iconSize,
              height: iconSize,
            ),
          ),
        if(Responsive.isMobile(context))
        SizedBox(height: 6),
        if(Responsive.isMobile(context))
        FloatingActionButton(
          mini: true,
          backgroundColor: theme.colors.surface,
          heroTag: "reset_all",
          onPressed: onResetPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: AppImage(
            theme.assets.resetIcon,
            width: iconSize,
            height: iconSize,
          ),
        ),
        if(Responsive.isMobile(context))
        SizedBox(height: 6),
        FloatingActionButton(
          mini: true,
          backgroundColor: theme.colors.surface,
          heroTag: "center_location",
          onPressed: onLocationPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: AppImage(
            theme.assets.locationIcon,
            width: iconSize,
            height: iconSize,
          ),
        ),
        SizedBox(height: 8),
        if(!Responsive.isMobile(context))
        FloatingActionButton(
          mini: true,
          backgroundColor: theme.colors.surface,
          heroTag: "zoom_in",
          onPressed: onZoomInPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight:  Radius.circular(8.0)),
          ),
          child: AppImage(
            theme.assets.zoomInIcon,
            width: iconSize,
            height: iconSize,
          ),
        ),
        if(!Responsive.isMobile(context))
        FloatingActionButton(
          mini: true,
          backgroundColor: theme.colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight:  Radius.circular(8.0)),
          ),
          heroTag: "zoom_out",
          onPressed: onZoomOutPressed,
          child: AppImage(
            theme.assets.zoomOutIcon,
            width: iconSize,
            height: iconSize,
          ),
        ),
      ],
    );
  }
}