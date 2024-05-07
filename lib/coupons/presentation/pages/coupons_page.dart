import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/pages/base_table_form_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/row_link_btn.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/coupons/bloc/coupon_bloc.dart';
import 'package:ecommerce_admin/coupons/model/coupon_model.dart';
import 'package:ecommerce_admin/coupons/presentation/widgets/coupon_general_body.dart';
import 'package:ecommerce_admin/coupons/presentation/widgets/coupon_usage_description.dart';
import 'package:ecommerce_admin/coupons/presentation/widgets/row_text_field.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CouponTable extends StatefulWidget {
  const CouponTable({super.key});

  @override
  State<CouponTable> createState() => _CouponTableState();
}

class _CouponTableState
    extends BaseTableFormWidgetState<CouponTable, CouponBloc, CouponState> {
  @override
  bool hasForm() {
    return false;
  }

  @override
  List<Widget> columnList() {
    final textTheme = getTextTheme();
    final isMSTABLET = getSize().width < MSTABLET;
    return [
      BlocBuilder<CouponBloc, CouponState>(
        builder: (context, state) {
          return Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: (state.selectedItems.isNotEmpty &&
                state.selectedItems.length == state.items.length),
            onChanged: (v) => context.read<CouponBloc>().add(
                  SelectAllItemsEvent(
                    isSelectAll: (v ?? false),
                  ),
                ),
          );
        },
      ),
      Text(
        "Coupon Code",
        style: textTheme.displaySmall,
      ),
      Text(
        "Orders",
        style: textTheme.displaySmall,
      ),
      if (!isMSTABLET) ...[
        Text(
          "Amount discounted",
          style: textTheme.displaySmall,
        ),
      ],
      if (!isMSTABLET) ...[
        Text(
          "Created",
          style: textTheme.displaySmall,
        ),
      ],
      if (!isMSTABLET) ...[
        Text(
          "Expired",
          style: textTheme.displaySmall,
        ),
      ],
      Text(
        "Type",
        style: textTheme.displaySmall,
      ),
    ];
  }

  @override
  void endOfFrame() {
    context.read<CouponBloc>().add(FetchEvent());
  }

  @override
  Widget getForm() {
    return Container();
  }

  @override
  Widget getSubmitButton() {
    return Container();
  }

  @override
  Widget getTitle() {
    return Container();
  }

  @override
  List<List<DataCell>> rowList(CouponState state) {
    final textTheme = getTextTheme();
    final isMSTABLET = getSize().width < MSTABLET;
    return List.generate(state.items.length, (index) {
      final item = state.items[index] as CouponModel;
      /* final item = CouponModel(
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
       */
      return [
        DataCell(
          Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.contains(
              item.id,
            ),
            onChanged: (v) => context.read<CouponBloc>().add(
                  SelectItemEvent(
                    value: v ?? false,
                    id: item.id,
                  ),
                ),
          ),
        ),
        DataCell(
          MainTitleText(
            e: item.couponCode ?? "ABC-11",
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
        if (!isMSTABLET) ...[
          DataCell(
            Text(
              "${item.amountDiscounted}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headlineMedium,
            ),
          )
        ],
        //created
        if (!isMSTABLET) ...[
          DataCell(
            Text(
              item.created.toString(),
              style: textTheme.headlineMedium,
            ),
          )
        ],
        //expired
        if (!isMSTABLET) ...[
          DataCell(
            Text(
              item.expired.toString(),
              style: textTheme.headlineMedium,
            ),
          )
        ],
        //type
        DataCell(
          Text(
            item.type.toString(),
            style: textTheme.headlineMedium,
          ),
        ),
      ];
    });
  }

  @override
  Widget topActions() {
    return Column(
      children: [
        TopActions(
          searchHint: "Search coupons",
          title: "Coupons",
          onSearch: () => context.read<CouponBloc>().add(
                SearchEvent(),
              ),
          onAddNew: () => context.read<CoreBloc>().add(
                ChangePageEvent(
                  page: PageType.editCoupons,
                ),
              ),
        ),
        Row(
          children: [
            Gap(20),
            BlocBuilder<CouponBloc, CouponState>(
              builder: (context, state) {
                return DropDownWidget(
                  hintText: "Actions",
                  items: const ["Edit", "Delete"],
                  width: 100,
                  value: state.selectedAction,
                  onChanged: (value) {
                    context
                        .read<CouponBloc>()
                        .add(ChangeActionsEvent(value: value ?? ""));
                  },
                );
              },
            ),
            10.hSpace(),
            LinkTextButton(
              width: 100,
              height: 35,
              onPressed: () {
                context.read<CouponBloc>().add(ActionApplyEvent());
              },
              text: "Apply",
              fillColor: linkBTNColor,
            ),
          ],
        )
      ],
    );
  }
}
/* class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    final isMSTABLET = size.width < MSTABLET;
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
                            iconOnly: isMSTABLET,
                            onPressed: () {
                              context.read<CouponBloc>().add(
                                  ChangeCouponDataTab(
                                      tab: CouponDataTab.general));
                            },
                            text: "General",
                            icon: FontAwesomeIcons.codeFork,
                            bgColor: state.dataTab == CouponDataTab.general
                                ? Colors.white
                                : Colors.grey.shade200,
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
                            iconOnly: isMSTABLET,
                            onPressed: () {
                              context.read<CouponBloc>().add(
                                  ChangeCouponDataTab(
                                      tab: CouponDataTab.usageRestriction));
                            },
                            icon: FontAwesomeIcons.plug,
                            text: "Usage restriction",
                            bgColor:
                                state.dataTab == CouponDataTab.usageRestriction
                                    ? Colors.white
                                    : Colors.grey.shade200,
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
                        minWidth: 20,
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
                          if (!isMSTABLET) ...[
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Amount discounted",
                                style: textTheme.displaySmall,
                              ),
                            )
                          ],
                          if (!isMSTABLET) ...[
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Created",
                                style: textTheme.displaySmall,
                              ),
                            )
                          ],
                          if (!isMSTABLET) ...[
                            DataColumn2(
                              size: ColumnSize.S,
                              label: Text(
                                "Expired",
                                style: textTheme.displaySmall,
                              ),
                            )
                          ],
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
                              if (!isMSTABLET) ...[
                                DataCell(
                                  Text(
                                    item.amountDiscounted,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.headlineMedium,
                                  ),
                                )
                              ],
                              //created
                              if (!isMSTABLET) ...[
                                DataCell(
                                  Text(
                                    item.created.toString(),
                                    style: textTheme.headlineMedium,
                                  ),
                                )
                              ],
                              //expired
                              if (!isMSTABLET) ...[
                                DataCell(
                                  Text(
                                    item.expired.toString(),
                                    style: textTheme.headlineMedium,
                                  ),
                                )
                              ],
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
 */