import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/core/formz/fromz_class.dart';
import 'package:ecommerce_admin/orders/model/app_order.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrderBloc extends BaseBloc<AppOrder, BaseEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<ChangeId>(_onChangeId);
    on<ChangeCustomerName>(_onChangeCustomerName);
    on<ChangeOrderStatus>(_onChangeOrderStatus);
    on<ChangeProduct>(_onChangeProduct);
    on<ChangePaymentMethod>(_onChangePaymentMethod);
    on<ChangeTotalAmount>(_onChangeTotlaAmount);
    on<ChangeShippingAddress>(_onChangeShippingAddress);
    on<ChangeOrderStatusFilter>(_onChangeOrderStatusFilter);
    on<ChangeOrderPaymentFilter>(_onChangeOrderPaymentFilter);
  }

  FutureOr<void> _onChangeId(ChangeId event, Emitter<OrderState> emit) {
    final id = RequiredInt.dirty(
      value: int.tryParse(event.value) ?? 0,
    );
    emit(
      state.copyWith(
          orderId: id,
          isValid: Formz.validate([
            id,
            state.customerName,
            state.product,
            state.paymentMethod,
            state.totalAmount,
            state.shippingAddress,
          ])),
    );
  }

  FutureOr<void> _onChangeCustomerName(
      ChangeCustomerName event, Emitter<OrderState> emit) {
    final customerName = RequiredDropdown.dirty(
      value: event.value,
    );
    emit(
      state.copyWith(
          customerName: customerName,
          isValid: Formz.validate([
            customerName,
            state.orderId,
            state.product,
            state.paymentMethod,
            state.totalAmount,
            state.shippingAddress,
          ])),
    );
  }

  FutureOr<void> _onChangeOrderStatus(
      ChangeOrderStatus event, Emitter<OrderState> emit) {
    emit(state.copyWith(orderStatus: event.value));
  }

  FutureOr<void> _onChangeProduct(
      ChangeProduct event, Emitter<OrderState> emit) {
    List<String> products = List.from(state.product.value);
    //if already contain, we remove
    if (products.contains(event.value)) {
      products.remove(event.value);
    } else {
      products.add(event.value);
    }
    //or add new
    final productList = RequiredObjectList.dirty(
      value: products,
    );
    emit(
      state.copyWith(
          product: productList,
          isValid: Formz.validate([
            state.orderId,
            state.customerName,
            productList,
            state.paymentMethod,
            state.totalAmount,
            state.shippingAddress,
          ])),
    );
  }

  FutureOr<void> _onChangePaymentMethod(
      ChangePaymentMethod event, Emitter<OrderState> emit) {
    final paymentMethod = RequiredDropdown.dirty(
      value: event.value,
    );
    emit(
      state.copyWith(
          paymentMethod: paymentMethod,
          isValid: Formz.validate([
            state.orderId,
            state.customerName,
            state.product,
            paymentMethod,
            state.totalAmount,
            state.shippingAddress,
          ])),
    );
  }

  FutureOr<void> _onChangeTotlaAmount(
      ChangeTotalAmount event, Emitter<OrderState> emit) {
    final totalAmount = RequiredDouble.dirty(
      value: double.tryParse(event.value) ?? 0,
    );
    emit(
      state.copyWith(
          totalAmount: totalAmount,
          isValid: Formz.validate([
            state.orderId,
            state.customerName,
            state.product,
            state.paymentMethod,
            totalAmount,
            state.shippingAddress,
          ])),
    );
  }

  FutureOr<void> _onChangeShippingAddress(
      ChangeShippingAddress event, Emitter<OrderState> emit) {
    final shippingAddress = RequiredText.dirty(
      value: event.value,
    );
    emit(
      state.copyWith(
          shippingAddress: shippingAddress,
          isValid: Formz.validate([
            state.orderId,
            state.customerName,
            state.product,
            state.paymentMethod,
            state.totalAmount,
            shippingAddress,
          ])),
    );
  }

  @override
  bool checkItemById(AppOrder item, int id) {
    return item.id == id;
  }

  @override
  int getId(e) {
    return e.di;
  }

  @override
  PageType getPageType() {
    return PageType.editOrders;
  }

  @override
  AppOrder parseFromJson(e) {
    return AppOrder.fromJson(e);
  }

  @override
  Future<String> requestData() async {
    return await rootBundle.loadString("assets/mock/orders.json");
  }

  FutureOr<void> _onChangeOrderStatusFilter(
      ChangeOrderStatusFilter event, Emitter<OrderState> emit) {
    emit(
      state.copyWith(filterOrderStatus: event.orderStatus),
    );
  }

  FutureOr<void> _onChangeOrderPaymentFilter(
      ChangeOrderPaymentFilter event, Emitter<OrderState> emit) {
    emit(state.copyWith(filterOrderPayment: event.paymentMethods));
  }
}
