import 'dart:developer';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_searchable.dart';
import 'package:ecommerce_admin/core/presentation/widgets/responsive_rowcolumn_textfield.dart';
import 'package:ecommerce_admin/orders/bloc/orders_bloc.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OrderForm extends StatelessWidget {
  const OrderForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      log("--🪖Order Form's Width : ${constraints.maxWidth}");
      return SingleChildScrollView(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Edit order",
              style: textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
              return ResponsiveRowColumnTextField(
                isExpanded: false,
                rowSpace: 80,
                textFieldWidth: size.width * 0.5,
                textFieldHeight: 45,
                hasFormError: (state.isFirstTimePressed &&
                    !(state.orderId.error == null)),
                label: "ORDER ID",
                labelWidth: 200,
                errorText: "* Order id is required.",
                onChanged: (v) => context.read<OrderBloc>().add(
                      ChangeId(value: v),
                    ),
              );
            }),
            //Order ID
            const Gap(20),
            BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
              return ResponsiveRowColumnTextField(
                isExpanded: false,
                rowSpace: 80,
                labelWidth: 200,
                textFieldWidth: size.width * 0.5,
                textFieldHeight: 45,
                hasFormError: (state.isFirstTimePressed &&
                    !(state.customerName.error == null)),
                label: "CUSTOMER NAME",
                errorText: "* Customer name is required.",
                onChanged: (v) => context.read<OrderBloc>().add(
                      ChangeCustomerName(value: v),
                    ),
              );
            }),
            const Gap(20),
            //Products
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    "Products",
                    style: textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  width: 40,
                  height: 5,
                ),
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return LabelDropDownSearchable<String>(
                      getName: (v) => v,
                      condition: state.isFirstTimePressed &&
                          !(state.product.error == null),
                      errorText: "* Products must be selected at least one.",
                      selectedItems: state.product.value,
                      textEditingController: TextEditingController(),
                      hintText: "Select products",
                      value: null,
                      onChanged: (v) =>
                          context.read<OrderBloc>().add(ChangeProduct(
                                value: v ?? "",
                              )),
                      items: const [
                        "Sholom Sisey",
                        "Mufinella Bourke",
                        "Dilan Tohill",
                        "Ines Udall",
                        "Dom Hayles",
                        "Zsa zsa Broun",
                        "Leelah Raith",
                      ],
                    );
                  },
                ),
              ],
            ),

            const Gap(5),
            BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 240),
                child: SizedBox(
                  width: size.width * 0.4,
                  child: Wrap(
                    children: state.product.value
                        .map((e) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              child: Chip(
                                elevation: 0,
                                deleteIcon: const Icon(
                                  Icons.clear,
                                  size: 18,
                                ),
                                deleteIconColor: Colors.white,
                                onDeleted: () => context
                                    .read<OrderBloc>()
                                    .add(ChangeProduct(value: e)),
                                backgroundColor: linkBTNColor,
                                labelStyle: textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                ),
                                label: Text(
                                  e,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              );
            }),
            const Gap(25),
            //Total Amount
            BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
              return ResponsiveRowColumnTextField(
                isExpanded: false,
                rowSpace: 80,
                labelWidth: 200,
                textFieldWidth: size.width * 0.5,
                textFieldHeight: 45,
                hasFormError: (state.isFirstTimePressed &&
                    !(state.totalAmount.error == null)),
                label: "TOTAL AMOUNT",
                errorText: "* Total amount is required.",
                onChanged: (v) => context.read<OrderBloc>().add(
                      ChangeTotalAmount(value: v),
                    ),
              );
            }),

            const Gap(25),
            //Shipping Address
            BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
              return ResponsiveRowColumnTextField(
                isExpanded: false,
                rowSpace: 80,
                labelWidth: 200,
                textFieldWidth: size.width * 0.5,
                textFieldHeight: 45,
                hasFormError: (state.isFirstTimePressed &&
                    !(state.shippingAddress.error == null)),
                label: "SHIPPING ADDRESS",
                errorText: "* Shipping address is required.",
                onChanged: (v) => context.read<OrderBloc>().add(
                      ChangeShippingAddress(value: v),
                    ),
              );
            }),

            const Gap(25),
            //Payment Methods
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    "PAYMENT METHOD",
                    style: textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  width: 40,
                  height: 5,
                ),
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return LabelDropDownSearchable<String>(
                      getName: (v) => v,
                      condition: state.isFirstTimePressed &&
                          !(state.paymentMethod.error == null),
                      errorText: "* Payment must be selected.",
                      textEditingController: TextEditingController(),
                      hintText: "Select",
                      value: state.paymentMethod.value,
                      onChanged: (v) =>
                          context.read<OrderBloc>().add(ChangePaymentMethod(
                                value: v ?? "",
                              )),
                      items: const [
                        "Cards",
                        "Bill payment",
                        "Internet Banking",
                        " PromptPay",
                        "SiamPay",
                        "iPay88",
                        "Omise",
                        "TrueMoney",
                        "2Checkout",
                        "Alipay",
                        "Codapay",
                        "Installment payments",
                        "PayPal",
                      ],
                    );
                  },
                ),
              ],
            ),
            const Gap(25),

            //Order Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    "ORDER STATUS",
                    style: textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  width: 40,
                  height: 5,
                ),
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return LabelDropDownSearchable<String>(
                      condition: false,
                      getName: (v) => v,
                      textEditingController: TextEditingController(),
                      hintText: "Select",
                      value: state.orderStatus,
                      onChanged: (v) =>
                          context.read<OrderBloc>().add(ChangeOrderStatus(
                                value: v ?? "",
                              )),
                      items: const [
                        "Pending Payment",
                        "Processing",
                        "On hold",
                        "Completed",
                        "Cancelled",
                        "Refunded",
                        "Failed",
                        "Draft",
                      ],
                    );
                  },
                ),
              ],
            ),
            Gap(40),
            //Submitted Button
            ElevatedButton(
                onPressed: () => context.read<OrderBloc>().add(AddEvent()),
                child: Text(
                  "Submit",
                  style: textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ).withPadding(20, 20),
      );
    });
  }
}
