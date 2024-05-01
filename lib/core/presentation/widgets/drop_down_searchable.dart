import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LabelDropDownSearchable<T> extends StatelessWidget {
  const LabelDropDownSearchable({
    super.key,
    required this.items,
    required this.textEditingController,
    required this.hintText,
    this.width,
    this.height,
    this.label,
    this.onChanged,
    this.value,
    this.selectedItems = const [],
    this.getName,
    this.isSelected,
  });
  final List<T> items;
  final TextEditingController textEditingController;
  final String hintText;
  final String? label;
  final double? height;
  final double? width;
  final void Function(T?)? onChanged;
  final T? value;
  final List<T> selectedItems;
  final String Function(T t)? getName;
  final bool Function(T t)? isSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
      return ResponsiveRowColumn(
        layout: constraints.maxWidth > 450
            ? ResponsiveRowColumnType.ROW
            : ResponsiveRowColumnType.COLUMN,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveRowColumnItem(
            child: label == null
                ? const Gap(0)
                : Text(
                    label!,
                    style: textTheme.bodyLarge,
                  ),
          ),
          const ResponsiveRowColumnItem(
              child: SizedBox(
            height: 5,
            width: 40,
          )),
          ResponsiveRowColumnItem(
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<T>(
                isExpanded: true,
                hint: Text(
                  hintText,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),

                items: items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Container(
                            color: (!(isSelected == null) && isSelected!(item))
                                ? linkBTNColor
                                : selectedItems.contains(item)
                                    ? linkBTNColor
                                    : null,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              getName == null ? T.toString() : getName!(item),
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    (!(isSelected == null) && isSelected!(item))
                                        ? Colors.white
                                        : selectedItems.contains(item)
                                            ? Colors.white
                                            : null,
                              ),
                            ),
                          ),
                        ))
                    .toList(),
                value: value,
                onChanged: onChanged,
                buttonStyleData: ButtonStyleData(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: height ?? 40,
                  width: width ?? 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade500,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        5,
                      ),
                    ),
                  ),
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                  padding: EdgeInsets.zero,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value
                        .toString()
                        .toLowerCase()
                        .contains(searchValue);
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
