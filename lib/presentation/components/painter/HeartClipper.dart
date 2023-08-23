import 'package:flutter/material.dart';

class HeartClipper extends CustomPainter {
  final Color backgroundColor;

  HeartClipper({
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

    Path path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.1);
    path.cubicTo(size.width * 1, size.height * -0.3, size.width * 1.3, size.height * 0.5, size.width * 0.5, size.height);
    path.moveTo(size.width * 0.5, size.height * 0.1);
    path.cubicTo(size.width * 0, size.height * -0.3, size.width * -0.3, size.height * 0.5, size.width * 0.5, size.height);

    canvas.drawPath(path, fillPaint); // Draw the fill color
    canvas.drawPath(path, borderPaint); // Draw the border
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
