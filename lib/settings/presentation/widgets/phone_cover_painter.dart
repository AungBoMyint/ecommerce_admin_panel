import 'package:flutter/material.dart';

class PhoneCoverPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw a simple gradient as a background
    final Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    const Gradient gradient = LinearGradient(
      colors: [Colors.deepPurple, Colors.pink],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    Paint paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Draw some text or shapes as part of the design
    var textSpan = const TextSpan(
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      text: 'Design Here',
    );
    var textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(
        canvas,
        Offset(size.width / 2 - textPainter.width / 2,
            size.height / 2 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
