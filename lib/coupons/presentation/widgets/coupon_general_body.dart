import 'dart:developer';

import 'package:data_table_2/data_table_2.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/coupons/bloc/coupon_bloc.dart';
import 'package:ecommerce_admin/coupons/model/coupon_model.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

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
