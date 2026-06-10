import 'package:flutter/material.dart';

/// A network image with a built-in fallback placeholder. Used for thumbnails
/// in lists (e.g. recent alerts) so we don't repeat
/// `Image.network(..., errorBuilder: ...)` blocks everywhere.
class AppNetworkImage extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;

  const AppNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final Widget fallback = placeholder ??
        Container(
          width: width,
          height: height,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey.shade500,
          ),
        );

    final String? trimmed = url?.trim();
    Widget image;
    if (trimmed == null || trimmed.isEmpty) {
      image = fallback;
    } else {
      image = Image.network(
        trimmed,
        width: width,
        height: height,
        fit: fit,
        gaplessPlayback: true,
        filterQuality: FilterQuality.medium,
        errorBuilder: (_, _, _) => fallback,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return SizedBox(
            width: width,
            height: height,
            child: const Center(
              child: SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }
}
