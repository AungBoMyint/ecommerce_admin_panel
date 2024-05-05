import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'drop_down_widget.dart';

class LabelDropDown extends StatelessWidget {
  const LabelDropDown({
    super.key,
    required this.label,
    required this.items,
    required this.hintText,
    required this.value,
    required this.onChanged,
    this.width,
  });
  final String label;
  final List<String> items;
  final String hintText;
  final String? value;
  final double? width;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
      log("Label Column's MaxWidth: ${constraints.maxWidth}");
      return ResponsiveRowColumn(
        layout: constraints.maxWidth > 450
            ? ResponsiveRowColumnType.ROW
            : ResponsiveRowColumnType.COLUMN,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label.isEmpty
              ? const ResponsiveRowColumnItem(child: Gap(0))
              : ResponsiveRowColumnItem(
                  child: Text(
                    label,
                    style: textTheme.bodyLarge,
                  ),
                ),
          label.isEmpty
              ? const ResponsiveRowColumnItem(child: Gap(0))
              : const ResponsiveRowColumnItem(
                  child: SizedBox(
                  height: 5,
                  width: 40,
                )),
          ResponsiveRowColumnItem(
            child: DropDownWidget(
              hintText: hintText,
              height: 40,
              width: width,
              items: items,
              onChanged: onChanged,
              value: value,
            ),
          ),
        ],
      );
    });
  }
}
