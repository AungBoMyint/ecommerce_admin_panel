import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(const PaymentState()) {
    on<Toggle2C2PPayment>(_onToggle2C2PPayment);
    on<ToggleCashOnDelivery>(_onToggleCashOnDelivery);
  }

  FutureOr<void> _onToggle2C2PPayment(
      Toggle2C2PPayment event, Emitter<PaymentState> emit) {
    emit(state.copyWith(enable2C2P: event.value));
  }

  FutureOr<void> _onToggleCashOnDelivery(
      ToggleCashOnDelivery event, Emitter<PaymentState> emit) {
    emit(state.copyWith(enableCashOnDelivery: event.value));
  }
}
