import 'package:flutter/material.dart';

class CircleClipper extends CustomPainter {
  final Color backgroundColor;

  CircleClipper({
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFFE1E1E1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    canvas.drawCircle(center, radius, fillPaint); // Draw the fill color
    canvas.drawCircle(center, radius, borderPaint); // Draw the border
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
