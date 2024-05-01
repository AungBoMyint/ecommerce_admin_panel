import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../theme/colors.dart';

class RowLinkButton extends StatelessWidget {
  const RowLinkButton({
    super.key,
    this.bgColor,
    this.iColor,
    this.textStyle,
    required this.text,
    this.onPressed,
    this.iconOnly = false,
  });
  final Color? bgColor;
  final Color? iColor;
  final TextStyle? textStyle;
  final String text;
  final void Function()? onPressed;
  final bool iconOnly;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor ?? linkBTNColor,
        ),
        width: iconOnly ? 50 : 200,
        child: Row(
          children: [
            Icon(
              Icons.settings,
              color: iColor ?? linkBTNColor,
              size: 15,
            ),
            iconOnly ? Gap(0) : 10.hSpace(),
            iconOnly
                ? Gap(0)
                : Text(
                    text,
                    style: textStyle ??
                        textTheme.bodyMedium?.copyWith(
                          color: linkBTNColor,
                        ),
                  )
          ],
        ),
      ),
    );
  }
}
