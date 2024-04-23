import 'package:flutter/material.dart';

class ActiveDrawerItemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(size.width, size.height * 0.2);
    path.lineTo(size.width - 10, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.8);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
