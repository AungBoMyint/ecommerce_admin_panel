part of 'orders_bloc.dart';

class OrderEvent extends BaseEvent {}

class ChangeOrderPaymentFilter extends OrderEvent {
  final String paymentMethods;
  ChangeOrderPaymentFilter({required this.paymentMethods});
}

class ChangeOrderStatusFilter extends OrderEvent {
  final String orderStatus;
  ChangeOrderStatusFilter({required this.orderStatus});
}

class ChangeShippingAddress extends OrderEvent {
  final String value;
  ChangeShippingAddress({required this.value});
}

class ChangeTotalAmount extends OrderEvent {
  final String value;
  ChangeTotalAmount({required this.value});
}

class ChangePaymentMethod extends OrderEvent {
  final String value;
  ChangePaymentMethod({required this.value});
}

class ChangeProduct extends OrderEvent {
  final String value;
  ChangeProduct({required this.value});
}

class ChangeId extends OrderEvent {
  final String value;
  ChangeId({required this.value});
}

class ChangeCustomerName extends OrderEvent {
  final String value;
  ChangeCustomerName({required this.value});
}

class ChangeOrderStatus extends OrderEvent {
  final String value;
  ChangeOrderStatus({required this.value});
}
