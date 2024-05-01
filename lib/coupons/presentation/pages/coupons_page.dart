import 'dart:developer';
import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/row_link_btn.dart';
import 'package:ecommerce_admin/coupons/bloc/coupon_bloc.dart';
import 'package:ecommerce_admin/coupons/model/coupon_model.dart';
import 'package:ecommerce_admin/coupons/presentation/widgets/row_text_field.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:gap/gap.dart';

import '../../../core/data/actions_status.dart';
import '../../../core/presentation/widgets/form_error_conditions.dart';
import '../../../core/presentation/widgets/loading_widget.dart';
import '../widgets/row_search_field.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20),

            //Coupon Forms
            Text(
              "Add New Coupon",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(20),
            //Coupon Form
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextFormField(
                cursorHeight: 15,
                onChanged: (v) => context
                    .read<CouponBloc>()
                    .add(ChangeCouponCodeEvent(value: v)),
                decoration: const InputDecoration(
                  hintText: "Coupon code",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                  ),
                ),
              ),
            ),
            FormErrorCondition<CouponBloc, CouponState>(
                condition: (state) {
                  return state.isFirstTimePressed &&
                      !(state.couponCode.error == null);
                },
                errorText: "* Coupon code is required."),
            Gap(15),
            SizedBox(
              width: double.infinity,
              height: 80,
              child: TextFormField(
                cursorHeight: 15,
                onChanged: (v) => context
                    .read<CouponBloc>()
                    .add(ChangeDescriptionEvent(value: v)),
                maxLines: 3,
                decoration: const InputDecoration(
                    hintText: "Coupon description",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    )),
              ),
            ),
            Gap(15),
            //Coupon Data Tab
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      BlocBuilder<CouponBloc, CouponState>(
                        builder: (context, state) {
                          return RowLinkButton(
                            onPressed: () {
                              context.read<CouponBloc>().add(
                                  ChangeCouponDataTab(
                                      tab: CouponDataTab.general));
                            },
                            text: "General",
                            bgColor: state.dataTab == CouponDataTab.general
                                ? Colors.grey.shade200
                                : Colors.white,
                            iColor: state.dataTab == CouponDataTab.general
                                ? Colors.grey.shade400
                                : null,
                            textStyle: state.dataTab == CouponDataTab.general
                                ? textTheme.bodyMedium
                                : null,
                          );
                        },
                      ),
                      BlocBuilder<CouponBloc, CouponState>(
                        builder: (context, state) {
                          return RowLinkButton(
                            onPressed: () {
                              context.read<CouponBloc>().add(
                                  ChangeCouponDataTab(
                                      tab: CouponDataTab.usageRestriction));
                            },
                            text: "Usage restriction",
                            bgColor:
                                state.dataTab == CouponDataTab.usageRestriction
                                    ? Colors.grey.shade200
                                    : Colors.white,
                            iColor:
                                state.dataTab == CouponDataTab.usageRestriction
                                    ? Colors.grey.shade400
                                    : null,
                            textStyle:
                                state.dataTab == CouponDataTab.usageRestriction
                                    ? textTheme.bodyMedium
                                    : null,
                          );
                        },
                      ),
                    ],
                  ),

                  //Data Tab Body
                  BlocBuilder<CouponBloc, CouponState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: 650,
                        height:
                            state.dataTab == CouponDataTab.general ? 240 : null,
                        child: Builder(
                          builder: (context) {
                            switch (state.dataTab) {
                              case CouponDataTab.general:
                                return const CouponGeneralTabBody();
                              case CouponDataTab.usageRestriction:
                                return const CouponUsageRestrictionTabBody2();
                              default:
                                return Container();
                            }
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Gap(20),
            //sumbit button
            ElevatedButton(
              onPressed: () {
                context.read<CouponBloc>().add(AddEvent());
              },
              child: Text(
                "Save",
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Gap(20),
            //Coupon Tables
            BlocBuilder<CouponBloc, CouponState>(
              builder: (context, state) {
                switch (state.actionStatus) {
                  case ActionStatus.fetching:
                    return const Expanded(child: LoadingWidget());
                  case ActionStatus.searching:
                    return const Expanded(child: LoadingWidget());
                  default:
                    return SizedBox(
                      height: 10 * 60,
                      width: double.infinity,
                      child: DataTable2(
                        minWidth: 200,
                        border: TableBorder.symmetric(
                            outside: BorderSide(color: Colors.grey.shade300)),
                        columns: [
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Checkbox(
                              side: const BorderSide(
                                  width: 2, color: linkBTNColor),
                              value: state.selectedItems.length ==
                                  state.items.length,
                              onChanged: (v) => context.read<CouponBloc>().add(
                                    SelectAllItemsEvent(
                                      isSelectAll: v ?? false,
                                    ),
                                  ),
                            ),
                          ),
                          DataColumn2(
                            size: ColumnSize.M,
                            label: Text(
                              "Coupon Code",
                              style: textTheme.displaySmall,
                            ),
                          ),
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Text(
                              "Orders",
                              style: textTheme.displaySmall,
                            ),
                          ),
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Text(
                              "Amount discounted",
                              style: textTheme.displaySmall,
                            ),
                          ),
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Text(
                              "Created",
                              style: textTheme.displaySmall,
                            ),
                          ),
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Text(
                              "Expired",
                              style: textTheme.displaySmall,
                            ),
                          ),
                          DataColumn2(
                            size: ColumnSize.S,
                            label: Text(
                              "Type",
                              style: textTheme.displaySmall,
                            ),
                          ),
                        ],
                        rows:
                            List.generate(10 /* state.items.length */, (index) {
                          /* final item = state.items[index] as CouponModel; */
                          final item = CouponModel(
                            id: 0,
                            couponCode: "couponCode",
                            description: "description",
                            orders: 1,
                            amountDiscounted: "amountDiscounted",
                            created: DateTime.now(),
                            expired: DateTime.now(),
                            type: CouponType.empty,
                            allowFreeShipping: false,
                            minimunSpend: 0,
                            maximunSpend: 0,
                            includeProducts: [],
                            excludeProducts: [],
                            includeCategories: [],
                            excludeCategories: [],
                          );
                          return DataRow2(
                            specificRowHeight: 100,
                            color: (index % 2 == 0)
                                ? MaterialStateProperty.all(
                                    Colors.grey.shade100)
                                : MaterialStateProperty.all(Colors.white),
                            cells: [
                              DataCell(
                                Checkbox(
                                  side: const BorderSide(
                                      width: 2, color: linkBTNColor),
                                  value: state.selectedItems.contains(
                                    item.id,
                                  ),
                                  onChanged: (v) =>
                                      context.read<CouponBloc>().add(
                                            SelectItemEvent(
                                              value: v ?? false,
                                              id: item.id,
                                            ),
                                          ),
                                ),
                              ),
                              DataCell(
                                MainTitleText(
                                  e: item.couponCode,
                                  onEdit: () => context.read<CoreBloc>().add(
                                        ChangePageEvent(
                                          page: PageType.editCoupons,
                                        ),
                                      ),
                                ),
                              ),
                              //Orders
                              DataCell(
                                Text(
                                  "${item.orders}",
                                  style: textTheme.headlineMedium,
                                ),
                              ),
                              //amounted discount
                              DataCell(
                                Text(
                                  item.amountDiscounted,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.headlineMedium,
                                ),
                              ),
                              //created
                              DataCell(
                                Text(
                                  item.created.toString(),
                                  style: textTheme.headlineMedium,
                                ),
                              ),
                              //expired
                              DataCell(
                                Text(
                                  item.expired.toString(),
                                  style: textTheme.headlineMedium,
                                ),
                              ),
                              //type
                              DataCell(
                                Text(
                                  item.type.toString(),
                                  style: textTheme.headlineMedium,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    );
                }
              },
            ),
          ],
        ).withPadding(20, 0),
      ),
    );
  }
}

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

class CouponGeneralTabBody extends StatelessWidget {
  const CouponGeneralTabBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DataTable2(
      headingRowHeight: 0,
      border: null,
      showBottomBorder: true,
      columns: const [
        DataColumn2(
          label: Text(""),
          size: ColumnSize.S,
        ),
        DataColumn2(
          label: Text(""),
          size: ColumnSize.L,
        ),
        DataColumn2(
          label: Text(""),
          size: ColumnSize.S,
          fixedWidth: 20,
        ),
      ],
      rows: [
        DataRow2(
          specificRowHeight: 60,
          cells: [
            const DataCell(Text("Discount type")),
            DataCell(
              BlocBuilder<CouponBloc, CouponState>(
                builder: (context, state) {
                  return DropDownWidget<CouponTypeModel>(
                    width: 300,
                    hintText: "",
                    items: couponTypes,
                    value: state.couponType.value,
                    onChanged: (v) => context
                        .read<CouponBloc>()
                        .add(ChangeCouponTypeEvent(couponType: v!)),
                  );
                },
              ),
            ),
            DataCell(Container()),
          ],
        ),
        DataRow2(
          specificRowHeight: 60,
          cells: [
            const DataCell(Text("Coupon amount")),
            DataCell(
              SizedBox(
                height: 40,
                child: TextFormField(
                  cursorHeight: 15,
                  onChanged: (v) => context
                      .read<CouponBloc>()
                      .add(ChangeAmountEvent(value: v)),
                  decoration: const InputDecoration(
                    hintText: "0",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(
                      left: 10,
                    ),
                  ),
                ),
              ),
            ),
            DataCell(Container()),
          ],
        ),
        DataRow2(specificRowHeight: 60, cells: [
          const DataCell(Text("Allow free shipping")),
          DataCell(Row(
            children: [
              BlocBuilder<CouponBloc, CouponState>(
                builder: (context, state) {
                  return Checkbox(
                    value: state.allowFreeShipping,
                    onChanged: (v) =>
                        context.read<CouponBloc>().add(ChangeAllowShipping(
                              value: v ?? false,
                            )),
                  );
                },
              ),
            ],
          )),
          DataCell(0.vSpace()),
        ]),
        DataRow2(
          specificRowHeight: 60,
          cells: [
            const DataCell(Text("Coupon expiry date")),
            DataCell(
              SizedBox(
                height: 40,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  onTap: () async {
                    showRoundedDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                        borderRadius: 16,
                        styleDatePicker: MaterialRoundedDatePickerStyle(
                          backgroundHeader: Colors.white,
                          textStyleDayButton: textTheme.bodyMedium,
                          textStyleYearButton: textTheme.bodyLarge,
                          textStyleDayHeader: textTheme.bodyMedium,
                          textStyleCurrentDayOnCalendar: textTheme.bodyMedium,
                          textStyleDayOnCalendar: textTheme.bodyMedium,
                          textStyleDayOnCalendarSelected:
                              textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                          textStyleDayOnCalendarDisabled: textTheme.bodyMedium,
                          textStyleMonthYearHeader: textTheme.bodyMedium,
                          paddingDatePicker: EdgeInsets.all(0),
                          paddingMonthHeader: EdgeInsets.all(32),
                          paddingActionBar: EdgeInsets.all(16),
                          paddingDateYearHeader: EdgeInsets.all(32),
                          sizeArrow: 30,
                          colorArrowNext: Colors.black,
                          colorArrowPrevious: Colors.black,
                          marginLeftArrowPrevious: 16,
                          marginTopArrowPrevious: 16,
                          marginTopArrowNext: 16,
                          marginRightArrowNext: 32,
                          textStyleButtonAction: textTheme.bodyMedium,
                          textStyleButtonPositive: textTheme.bodyMedium,
                          textStyleButtonNegative:
                              textTheme.bodyMedium?.copyWith(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          decorationDateSelected: const BoxDecoration(
                            color: linkBTNColor,
                            shape: BoxShape.circle,
                          ),
                          backgroundPicker: Colors.white,
                          backgroundActionBar: Colors.white,
                          backgroundHeaderMonth: Colors.white,
                        )).then((newDateTime) {
                      log("🍾-Selected DateTime ${newDateTime.toString()}");
                      context.read<CouponBloc>().add(ChangeExpiredDate(
                          value: newDateTime ?? DateTime.now()));
                    });
                  },
                  child: Container(
                    height: 34,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: Colors.black,
                        )),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BlocBuilder<CouponBloc, CouponState>(
                        builder: (context, state) {
                          return Text(
                            state.expireDate.value == null
                                ? "YYY-MM-DD"
                                : formatDMYDash(state.expireDate.value!),
                            textAlign: TextAlign.left,
                          );
                        },
                      ).withPadding(10, 0),
                    ),
                  ),
                ),
              ),
            ),
            DataCell(Container()),
          ],
        ),
      ],
    );
  }
}
