import 'package:flutter/material.dart';

extension HorizontalSpace on int {
  Widget hSpace() => SizedBox(
        width: this + 0.0,
      );
}

extension VerticalSpace on int {
  Widget vSpace() => SizedBox(
        height: this + 0.0,
      );
}

extension PaddingExtension on Widget {
  Widget withPadding(int h, int v) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: h + 0.0,
          vertical: v + 0.0,
        ),
        child: this,
      );
}

extension MarginExtension on Widget {
  Widget withMargin(int h, int v) => Container(
        margin: EdgeInsets.symmetric(
          horizontal: h + 0.0,
          vertical: v + 0.0,
        ),
        child: this,
      );
}

extension ElevationExtension on Widget {
  Widget withElevation({double? h, double? v, BoxBorder? border}) => Container(
        padding: EdgeInsets.symmetric(horizontal: h ?? 0, vertical: v ?? 0),
        decoration: BoxDecoration(
          border: border,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.grey.shade200,
            ),
            BoxShadow(
              offset: const Offset(-2, -2),
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.grey.shade200,
            ),
          ],
          color: Colors.white,
        ),
        child: this,
      );
}
