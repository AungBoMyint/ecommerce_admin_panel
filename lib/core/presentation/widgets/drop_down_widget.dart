import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.hintText,
    required this.items,
    this.width,
    this.height,
    this.hintStyle,
    this.value,
    this.onChanged,
  });

  final String hintText;
  final List<T> items;
  final double? width;
  final double? height;
  final TextStyle? hintStyle;
  final T? value;
  final Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: false,
        hint: Text(
          hintText,
          style: hintStyle ?? textTheme.bodyMedium,
        ),
        items: items
            .map((T item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    item.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(
            left: 5,
          ),
          height: height ?? 35,
          width: width ?? 160,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade500,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  5,
                ),
              )),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
