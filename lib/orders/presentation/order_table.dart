import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/pages/base_table_form_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/orders/bloc/orders_bloc.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/colors.dart';

class OrderTable extends StatefulWidget {
  const OrderTable({super.key});

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState
    extends BaseTableFormWidgetState<OrderTable, OrderBloc, OrderState> {
  @override
  List<Widget> columnList() {
    final textTheme = getTextTheme();
    final isXTABLET = getSize().width < XTABLET;
    final isxTABLET = getSize().width < xTABLET;
    return [
      BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.length == state.items.length,
            onChanged: (v) => context.read<OrderBloc>().add(
                  SelectAllItemsEvent(
                    isSelectAll: v ?? false,
                  ),
                ),
          );
        },
      ),
      if (!isxTABLET)
        Text(
          "ID",
          style: textTheme.displaySmall,
        ),
      Text(
        "Customer",
        style: textTheme.displaySmall,
      ),
      Text(
        "Status",
        style: textTheme.displaySmall,
      ),
      Text(
        "Product",
        style: textTheme.displaySmall,
      ),
      if (!isxTABLET)
        Text(
          "Total",
          style: textTheme.displaySmall,
        ),
      if (!isXTABLET)
        Text(
          "Address",
          style: textTheme.displaySmall,
        ),
      if (!isXTABLET)
        Text(
          "Payment",
          style: textTheme.displaySmall,
        ),
      /* Text(
        "Order At",
        style: textTheme.displaySmall,
      ),
      Text(
        "Updated At",
        style: textTheme.displaySmall,
      ), */
    ];
  }

  @override
  void endOfFrame() {
    context.read<OrderBloc>().add(FetchEvent());
  }

  @override
  bool hasForm() {
    return false;
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
  List<List<DataCell>> rowList(OrderState state) {
    final textTheme = getTextTheme();
    final isXTABLET = getSize().width < XTABLET;
    final isxTABLET = getSize().width < xTABLET;
    return List.generate(state.items.length, (index) {
      final item = state.items[index];
      return [
        DataCell(
          Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.contains(
              item.id,
            ),
            onChanged: (v) => context.read<OrderBloc>().add(
                  SelectItemEvent(
                    value: v ?? false,
                    id: item.id,
                  ),
                ),
          ),
        ),
        if (!isxTABLET)
          DataCell(
            MainTitleText(
              e: "#000${item.id}",
              onEdit: () => context.read<CoreBloc>().add(
                    ChangePageEvent(
                      page: PageType.editReview,
                    ),
                  ),
            ),
          ),
        //Customer Name
        DataCell(
          Text(
            item.customerName,
            style: textTheme.headlineMedium,
          ),
        ),
        //Order STatus
        DataCell(
          Container(
            decoration: BoxDecoration(
                color: getStatusBackground(item.orderStatus),
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(5),
            child: Text(
              item.orderStatus,
              style: textTheme.headlineMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        //Product
        DataCell(
          Text(
            item.product,
            style: textTheme.headlineMedium,
          ),
        ),
        //Total Amount
        if (!isxTABLET)
          DataCell(
            Text(
              "฿ ${item.totalAmount}",
              style: textTheme.headlineMedium,
            ),
          ),
        //Shipping Address
        if (!isXTABLET)
          DataCell(
            Text(
              item.shippingAddress,
              style: textTheme.headlineMedium,
            ),
          ),
        //Payment Method
        if (!isXTABLET)
          DataCell(
            Text(
              item.paymentMethods,
              style: textTheme.headlineMedium,
            ),
          ),
        /*  //Order at
        DataCell(
          Text(
            formatDMYDash(DateTime.now()),
            style: textTheme.headlineMedium,
          ),
        ),
        //Updated at
        DataCell(
          Text(
            formatDMYDash(DateTime.now()),
            style: textTheme.headlineMedium,
          ),
        ), */
      ];
    });
  }

  @override
  Widget topActions() {
    return Column(
      children: [
        TopActions(
          searchHint: "Search orders",
          title: "Orders",
          onSearch: () => context.read<OrderBloc>().add(
                SearchEvent(),
              ),
          onAddNew: () => context.read<CoreBloc>().add(
                ChangePageEvent(
                  page: PageType.editOrders,
                ),
              ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Wrap(
            runSpacing: 10,
            children: [
              BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return DropDownWidget(
                    hintText: "Actions",
                    items: const ["Edit", "Delete"],
                    width: 100,
                    value: state.selectedAction,
                    onChanged: (value) {
                      context
                          .read<OrderBloc>()
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
                  context.read<OrderBloc>().add(ActionApplyEvent());
                },
                text: "Apply",
                fillColor: linkBTNColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color getStatusBackground(String orderStatus) {
    switch (orderStatus) {
      case "Pending Payment":
        return Colors.amber;
      case "Processing":
        return Colors.yellow;
      case "On hold":
        return Colors.black;
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      case "Refunded":
        return Colors.blue;
      case "Failed":
        return const Color.fromARGB(255, 172, 19, 8);
      case "Draft":
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
