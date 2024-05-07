import 'package:flutter/material.dart';

class PhoneFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the outer frame of the phone
    Paint framePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    Radius cornerRadius = const Radius.circular(25); // Rounded corners for the phone
    RRect outerFrame = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, size.width, size.height),
      topLeft: cornerRadius,
      topRight: cornerRadius,
      bottomLeft: cornerRadius,
      bottomRight: cornerRadius,
    );
    canvas.drawRRect(outerFrame, framePaint);

    // Draw the screen area (slightly smaller than the frame)
    Paint screenPaint = Paint()..color = Colors.white;
    RRect screen = RRect.fromRectAndCorners(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      topLeft: cornerRadius,
      topRight: cornerRadius,
      bottomLeft: cornerRadius,
      bottomRight: cornerRadius,
    );
    canvas.drawRRect(screen, screenPaint);

    /* // Optionally draw a notch at the top if you like
    Paint notchPaint = Paint()..color = Colors.black;
    Rect notch = Rect.fromLTWH(size.width / 2 - 50, 0, 100, 20);
    canvas.drawRect(notch, notchPaint); */
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
