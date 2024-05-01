import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';

class MainTitleText extends StatefulWidget {
  const MainTitleText({
    super.key,
    required this.e,
    this.onEdit,
    this.onDelete,
  });

  final String e;
  final void Function()? onEdit;
  final void Function()? onDelete;

  @override
  State<MainTitleText> createState() => _MainTitleTextState();
}

class _MainTitleTextState extends State<MainTitleText> {
  bool isHover = false;
  void changeHover(bool v) {
    if (mounted) {
      setState(() {
        isHover = v;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onExit: (e) => changeHover(false),
      onHover: (e) => changeHover(true),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.e,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headlineMedium?.copyWith(
                decoration: isHover ? TextDecoration.underline : null,
                decorationColor: linkBTNColor,
                color: linkBTNColor,
                fontWeight: isHover ? FontWeight.bold : null,
              ),
            ),
            isHover ? 10.vSpace() : 0.vSpace(),
            isHover
                ? Row(
                    children: [
                      InkWell(
                        onTap: widget.onEdit,
                        child: Text(
                          "Edit",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: linkBTNColor),
                        ),
                      ),
                      10.hSpace(),
                      InkWell(
                        onTap: widget.onDelete,
                        child: Text(
                          "Delete",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: linkBTNColor),
                        ),
                      ),
                    ],
                  )
                : 0.vSpace(),
          ],
        ),
      ),
    );
  }
}
