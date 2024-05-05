import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveRowColumnTextField extends StatelessWidget {
  const ResponsiveRowColumnTextField({
    super.key,
    required this.hasFormError,
    this.errorHeight,
    this.normalHeight,
    required this.label,
    this.initialValue,
    required this.errorText,
    required this.onChanged,
    this.isExpanded = true,
    this.textFieldHeight,
    this.textFieldWidth,
    this.rowSpace,
    this.labelWidth,
  });

  final bool hasFormError;
  final double? errorHeight;
  final double? normalHeight;
  final String label;
  final String? initialValue;
  final String errorText;
  final void Function(String)? onChanged;
  final bool isExpanded;
  final double? textFieldHeight;
  final double? textFieldWidth;
  final double? rowSpace;
  final double? labelWidth;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: hasFormError ? (errorHeight ?? 100) : (normalHeight ?? 70),
      child: LayoutBuilder(builder: (context, constraints) {
        return ResponsiveRowColumn(
          layout: constraints.maxWidth > 420
              ? ResponsiveRowColumnType.ROW
              : ResponsiveRowColumnType.COLUMN,
          columnCrossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveRowColumnItem(
              child: SizedBox(
                width: labelWidth,
                child: Text(
                  label,
                  style: textTheme.bodyLarge,
                ),
              ),
            ),
            ResponsiveRowColumnItem(
                child: SizedBox(
              width: rowSpace ?? 40,
              height: 5,
            )),
            isExpanded
                ? ResponsiveRowColumnItem(
                    child: Expanded(
                      child: TextFormField(
                        cursorHeight: 15,
                        initialValue: initialValue,
                        onChanged: onChanged,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(
                            left: 10,
                          ),
                        ),
                      ),
                    ),
                  )
                : ResponsiveRowColumnItem(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: textFieldHeight,
                          width: textFieldWidth,
                          child: TextFormField(
                            cursorHeight: 15,
                            initialValue: initialValue,
                            onChanged: onChanged,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.only(
                                left: 10,
                              ),
                            ),
                          ),
                        ),
                        if (hasFormError) ErrorText(error: errorText)
                      ],
                    ),
                  ),
            const ResponsiveRowColumnItem(
              child: SizedBox(
                width: 20,
              ),
            ),
            if (isExpanded)
              ResponsiveRowColumnItem(
                child: hasFormError ? ErrorText(error: errorText) : 0.vSpace(),
              ),
            if (isExpanded)
              constraints.maxWidth > 420
                  ? ResponsiveRowColumnItem(
                      child: Expanded(
                      child: Container(),
                    ))
                  : ResponsiveRowColumnItem(child: 0.vSpace()),
          ],
        );
      }),
    );
  }
}
