import 'package:ecommerce_admin/coupons/bloc/coupon_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../core/constant.dart';
import '../../../core/presentation/widgets/drop_down_searchable.dart';

class RowSearchField<T> extends StatelessWidget {
  const RowSearchField({
    super.key,
    required this.isSelected,
    required this.label,
    required this.getName,
    required this.onChanged,
    required this.selectedItems,
    required this.onDeleted,
    required this.hintText,
  });
  final bool Function(Map<String, dynamic>)? isSelected;
  final String label;
  final String Function(Map<String, dynamic>)? getName;
  final void Function(Map<String, dynamic>?)? onChanged;
  final List<T> selectedItems;
  final void Function(Map<String, dynamic>?)? onDeleted;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
          ),
        ),
        const Gap(20),
        Expanded(
          child: SizedBox(
            child: BlocBuilder<CouponBloc, CouponState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LabelDropDownSearchable<Map<String, dynamic>>(
                      isSelected: isSelected,
                      getName: getName,
                      onChanged: onChanged,
                      items: List.generate(products.length, (index) {
                        return {
                          "id": index,
                          "name": products[index],
                        };
                      }),
                      textEditingController: TextEditingController(),
                      hintText: hintText,
                      width: 350,
                    ),
                    //Selected Include Products
                    selectedItems.isNotEmpty
                        ? Wrap(
                            children: selectedItems
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Chip(
                                        label: Text(getName!(
                                            e as Map<String, dynamic>)),
                                        onDeleted: () => onDeleted!(e),
                                      ),
                                    ))
                                .toList(),
                          )
                        : Gap(0),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
