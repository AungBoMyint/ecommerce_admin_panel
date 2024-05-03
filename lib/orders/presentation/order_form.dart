import 'dart:developer';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_searchable.dart';
import 'package:ecommerce_admin/core/presentation/widgets/form_error_conditions.dart';
import 'package:ecommerce_admin/orders/bloc/orders_bloc.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Edit order",
              style: textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(20),
            //Order ID
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveRowColumnItem(
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      "ORDER ID",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ),
                const ResponsiveRowColumnItem(
                  child: SizedBox(
                    width: 80,
                    height: 5,
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: SizedBox(
                    height: 45,
                    width: size.width * 0.5,
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return TextFormField(
                          cursorHeight: 15,
                          initialValue: state.orderId.value.toString(),
                          onChanged: (v) =>
                              context.read<OrderBloc>().add(ChangeId(value: v)),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            FormErrorCondition<OrderBloc, OrderState>(
                condition: (state) =>
                    state.isFirstTimePressed && !(state.orderId.error == null),
                errorText: "* Order id is required."),

            const Gap(40),
            //Customer name
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    "Customer Name",
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
                      textEditingController: TextEditingController(),
                      hintText: "Select a customer",
                      value: state.customerName.value,
                      onChanged: (v) =>
                          context.read<OrderBloc>().add(ChangeCustomerName(
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
            FormErrorCondition<OrderBloc, OrderState>(
                condition: (state) =>
                    state.isFirstTimePressed &&
                    !(state.customerName.error == null),
                errorText: "* Customer Name must be selected."),
            const Gap(40),
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
            FormErrorCondition<OrderBloc, OrderState>(
                condition: (state) =>
                    state.isFirstTimePressed &&
                    !(state.customerName.error == null),
                errorText: "* Products must be selected at least one."),
            const Gap(5),
            BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 240),
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
              );
            }),
            const Gap(25),
            //Total Amount
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveRowColumnItem(
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      "TOTAL AMOUNT",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ),
                const ResponsiveRowColumnItem(
                  child: SizedBox(
                    width: 80,
                    height: 5,
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: SizedBox(
                    height: 45,
                    width: size.width * 0.5,
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return TextFormField(
                          cursorHeight: 15,
                          initialValue: state.totalAmount.value.toString(),
                          onChanged: (v) => context
                              .read<OrderBloc>()
                              .add(ChangeTotalAmount(value: v)),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            FormErrorCondition<OrderBloc, OrderState>(
                condition: (state) =>
                    state.isFirstTimePressed &&
                    !(state.totalAmount.error == null),
                errorText: "* Total amount is required."),

            const Gap(25),
            //Shipping Address
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveRowColumnItem(
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      "SHIPPING ADDRESS",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                ),
                const ResponsiveRowColumnItem(
                  child: SizedBox(
                    width: 80,
                    height: 5,
                  ),
                ),
                ResponsiveRowColumnItem(
                  child: SizedBox(
                    height: 45,
                    width: size.width * 0.5,
                    child: BlocBuilder<OrderBloc, OrderState>(
                      builder: (context, state) {
                        return TextFormField(
                          cursorHeight: 15,
                          initialValue: state.shippingAddress.value.toString(),
                          onChanged: (v) => context
                              .read<OrderBloc>()
                              .add(ChangeShippingAddress(value: v)),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter customer's address",
                            contentPadding: EdgeInsets.only(
                              left: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            FormErrorCondition<OrderBloc, OrderState>(
                condition: (state) =>
                    state.isFirstTimePressed &&
                    !(state.shippingAddress.error == null),
                errorText: "* Shipping Address is required."),

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
            FormErrorCondition<OrderBloc, OrderState>(
                condition: (state) =>
                    state.isFirstTimePressed &&
                    !(state.paymentMethod.error == null),
                errorText: "* Payment must be selected."),
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
