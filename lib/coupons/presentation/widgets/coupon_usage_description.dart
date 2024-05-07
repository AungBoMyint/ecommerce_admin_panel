import 'package:ecommerce_admin/coupons/bloc/coupon_bloc.dart';
import 'package:ecommerce_admin/coupons/presentation/widgets/row_search_field.dart';
import 'package:ecommerce_admin/coupons/presentation/widgets/row_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CouponUsageRestrictionTabBody2 extends StatelessWidget {
  const CouponUsageRestrictionTabBody2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          //Minimum Spend
          BlocBuilder<CouponBloc, CouponState>(
            builder: (context, state) {
              return RowTextField(
                label: "Minimum Spend",
                initialValue: "${state.minumumSpend}",
                onChanged: (v) => context
                    .read<CouponBloc>()
                    .add(ChangeMinimumSpeed(value: int.tryParse(v) ?? 0)),
              );
            },
          ),
          Gap(25),
          //Maximum Spend
          BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
            return RowTextField(
              label: "Maximum Spend",
              initialValue: "${state.maximumSpend}",
              onChanged: (v) => context.read<CouponBloc>().add(
                    ChangeMaximumSpeed(
                      value: int.tryParse(v) ?? 0,
                    ),
                  ),
            );
          }),
          Gap(25),
          //Include Products
          BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
            return RowSearchField(
              hintText: "Search for a product",
              isSelected: (i) => contains(
                i,
                state.includeProducts,
              ),
              label: "Include Products",
              getName: (i) => i["name"],
              onChanged: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeIncludeProducts(value: v ?? {})),
              selectedItems: state.includeProducts,
              onDeleted: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeIncludeProducts(value: v ?? {})),
            );
          }),
          Gap(25),
          //Exclude Products
          BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
            return RowSearchField(
              isSelected: (i) => contains(
                i,
                state.excludeProducts,
              ),
              hintText: "Search for a product",
              label: "Exclude Products",
              getName: (i) => i["name"],
              onChanged: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeExcludeProducts(value: v ?? {})),
              selectedItems: state.excludeProducts,
              onDeleted: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeExcludeProducts(value: v ?? {})),
            );
          }),
          Gap(25),
          //Include Categories
          BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
            return RowSearchField(
              hintText: "Search for a category",
              isSelected: (i) => contains(
                i,
                state.includeCategories,
              ),
              label: "Include Categories",
              getName: (i) => i["name"],
              onChanged: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeIncludeCategories(value: v ?? {})),
              selectedItems: state.includeCategories,
              onDeleted: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeIncludeCategories(value: v ?? {})),
            );
          }),
          //Exclude Categories
          Gap(25),
          BlocBuilder<CouponBloc, CouponState>(builder: (context, state) {
            return RowSearchField(
              hintText: "Search for a category",
              isSelected: (i) => contains(
                i,
                state.excludeCategories,
              ),
              label: "Exclude Categories",
              getName: (i) => i["name"],
              onChanged: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeExcludeCategories(value: v ?? {})),
              selectedItems: state.excludeCategories,
              onDeleted: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeExcludeCategories(value: v ?? {})),
            );
          }),

          Gap(25),
        ],
      ),
    );
  }

  bool contains(Map<String, dynamic> item, List<Map<String, dynamic>> items) {
    for (var element in items) {
      if (element["id"] == item["id"]) {
        return true;
      }
    }
    return false;
  }
}
