import 'package:ecommerce_admin/settings/presentation/widgets/phone_frame_painter.dart';
import 'package:flutter/material.dart';


class ViewMyStore extends StatelessWidget {
  const ViewMyStore({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CustomPaint(
          size:
              const Size(360, 640), // Set this to your desired width and height
          painter: PhoneFramePainter(),
        ),
      ),
    );
  }
}
