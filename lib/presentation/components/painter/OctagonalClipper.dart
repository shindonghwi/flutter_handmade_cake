import 'package:flutter/material.dart';

class OctagonalClipper extends CustomPainter {
  final Color backgroundColor;

  OctagonalClipper({
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()..color = backgroundColor;
    final borderPaint = Paint()
      ..color = const Color(0xFFE1E1E1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.3, 0)
      ..lineTo(size.width * 0.7, 0)
      ..lineTo(size.width, size.height * 0.3)
      ..lineTo(size.width, size.height * 0.7)
      ..lineTo(size.width * 0.7, size.height)
      ..lineTo(size.width * 0.3, size.height)
      ..lineTo(0, size.height * 0.7)
      ..lineTo(0, size.height * 0.3)
      ..close();

    canvas.drawPath(path, fillPaint); // Draw the fill color
    canvas.drawPath(path, borderPaint); // Draw the border
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
