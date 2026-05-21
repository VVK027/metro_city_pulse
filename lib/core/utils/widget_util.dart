import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show BitmapDescriptor;

class WidgetUtil {
  static const Color _palettePrimary = Color(0xFF4671C6);
  static const Color _paletteSecondary = Color(0xFF3762CC);
  static const Color _paletteAccent = Color(0xFFA4C9FF);

  static Future<BitmapDescriptor> createClusterIcon(int count, int severity) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    // Pick Color based on severity
    final Color color = severity >= 8
        ? _paletteSecondary
        : severity >= 5
        ? _palettePrimary
        : _paletteAccent;

    const double radius = 60;

    final Paint circlePaint = Paint()..color = color;

    // Draw circle
    canvas.drawCircle(const Offset(radius, radius), radius, circlePaint);

    // Draw count text
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    )..layout();

    textPainter.paint(
      canvas,
      Offset(radius - textPainter.width / 2, radius - textPainter.height / 2),
    );

    final img = await recorder.endRecording().toImage((radius * 2).toInt(), (radius * 2).toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.bytes(Uint8List.view(data!.buffer));
  }


  static Future<BitmapDescriptor> getClusterBitmap(int count) async {
    final  ui.PictureRecorder recorder =  ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint()..color = _paletteSecondary;
    final double radius = 45;

    canvas.drawCircle(Offset(radius, radius), radius, paint);

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.text = TextSpan(
      text: count.toString(),
      style: TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(radius - textPainter.width / 2,
            radius - textPainter.height / 2));

    final img = await recorder
        .endRecording()
        .toImage((radius * 2).toInt(), (radius * 2).toInt());
    final data = await img.toByteData(format:  ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}