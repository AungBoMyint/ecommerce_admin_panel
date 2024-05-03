part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class Toggle2C2PPayment extends PaymentEvent {
  final bool value;
  Toggle2C2PPayment({required this.value});
}

class ToggleCashOnDelivery extends PaymentEvent {
  final bool value;
  ToggleCashOnDelivery({required this.value});
}
