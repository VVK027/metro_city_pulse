import 'package:metro_city_pulse/core/keys/generic_widget_keys.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

  const AppImage(this.path, {super.key, this.isFromAssets = true, this.width, this.height, this.fit, this.color, this.alignment = Alignment.center, this.isPlaceHolderRequired = false, this.placeHolderPath, this.placeHolderColor});

  bool _isSvg() => path.endsWith(".svg");

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: alignment,
      child: isFromAssets ? _getAssetImage() : _getNetworkImage(),
    );
  }


  Widget _getAssetImage() {
    return _isSvg()
        ?  SvgPicture.asset(
                      path,
                      key: const Key(AppImageKeys.image),
                      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
                      width: width,
                      height: height,
                      fit: fit ?? BoxFit.contain,
          )
        : Image.asset(path, key: const Key(AppImageKeys.image), width: width, height: height, fit: fit, color: color,);
  }

  Widget _getNetworkImage() {
    return _isSvg()
        ?  SvgPicture.network(
            path,
            key: const Key(AppImageKeys.image),
            colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
          )
        : Image.network(path);
  }
}