import 'package:ecommerce_admin/theme/colors.dart';
import 'package:flutter/material.dart';

class LinkTextButton extends StatelessWidget {
  const LinkTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.color,
    this.fillColor,
    this.width,
  });
  final void Function()? onPressed;
  final String text;
  final double? height;
  final Color? color;
  final Color? fillColor;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(
              color: color ?? linkBTNColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                5,
              ),
            )),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Center(
          child: Text(
            text,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: fillColor == null ? (color ?? linkBTNColor) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
