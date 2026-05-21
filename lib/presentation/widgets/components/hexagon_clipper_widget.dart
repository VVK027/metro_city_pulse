import 'package:flutter/widgets.dart';

/// A widget that displays its child clipped into a hexagon shape with a default size.
class HexagonWidget extends StatelessWidget {
  final Widget? child;
  final double width;
  final double height;

  const HexagonWidget({
    super.key,
    this.child,
    this.width = 100.0,
    this.height = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HexagonClipper(),
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double w = size.width;
    final double h = size.height;

    // This implementation stretches the hexagon to occupy the full width and height
    path.moveTo(w * 0.5, 0); // Top Center
    path.lineTo(w, h * 0.25); // Top Right
    path.lineTo(w, h * 0.75); // Bottom Right
    path.lineTo(w * 0.5, h); // Bottom Center
    path.lineTo(0, h * 0.75); // Bottom Left
    path.lineTo(0, h * 0.25); // Top Left
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
