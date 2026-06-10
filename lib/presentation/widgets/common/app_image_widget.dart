import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:metro_city_pulse/core/keys/generic_widget_keys.dart';

/// Lightweight wrapper that hides whether an asset is an SVG or a raster
/// image and whether it's local or remote. Used widely across the app for
/// icons, logos and small bitmaps.
class AppImage extends StatelessWidget {
  final String path;
  final bool isFromAssets;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final Alignment alignment;
  final String? placeHolderPath;
  final Color? placeHolderColor;
  final bool isPlaceHolderRequired;

  const AppImage(
    this.path, {
    super.key,
    this.isFromAssets = true,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.alignment = Alignment.center,
    this.isPlaceHolderRequired = false,
    this.placeHolderPath,
    this.placeHolderColor,
  });

  bool get _isSvg => path.endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    // Wrap the actual image in a RepaintBoundary so that frequent rebuilds in
    // the parent (e.g. a screen polling a Riverpod provider every minute) do
    // not invalidate the rasterized icon layer.
    return RepaintBoundary(
      child: Container(
        width: width,
        height: height,
        alignment: alignment,
        child: isFromAssets ? _getAssetImage() : _getNetworkImage(),
      ),
    );
  }

  Widget _getAssetImage() {
    if (_isSvg) {
      return SvgPicture.asset(
        path,
        key: const Key(AppImageKeys.image),
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
    }
    return Image.asset(
      path,
      key: const Key(AppImageKeys.image),
      width: width,
      height: height,
      fit: fit,
      color: color,
      gaplessPlayback: true,
      filterQuality: FilterQuality.medium,
    );
  }

  Widget _getNetworkImage() {
    if (_isSvg) {
      return SvgPicture.network(
        path,
        key: const Key(AppImageKeys.image),
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
    }
    return Image.network(
      path,
      width: width,
      height: height,
      fit: fit,
      color: color,
      gaplessPlayback: true,
      filterQuality: FilterQuality.medium,
    );
  }
}
