import 'package:flutter/material.dart';

class RectClipper extends CustomPainter {
  final Color backgroundColor;

  RectClipper({
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = const Color(0xFFE1E1E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final Rect rect = Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height));

    canvas.drawRect(rect, fillPaint); // paint rectangle fill
    canvas.drawRect(rect, borderPaint); // paint rectangle border
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
