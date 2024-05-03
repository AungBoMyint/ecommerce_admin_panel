// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

class PaymentState extends Equatable {
  final bool enable2C2P;
  final bool enableCashOnDelivery;
  const PaymentState(
      {this.enable2C2P = false, this.enableCashOnDelivery = true});

  @override
  List<Object?> get props => [
        enable2C2P,
        enableCashOnDelivery,
      ];

  PaymentState copyWith({
    bool? enable2C2P,
    bool? enableCashOnDelivery,
  }) {
    return PaymentState(
      enable2C2P: enable2C2P ?? this.enable2C2P,
      enableCashOnDelivery: enableCashOnDelivery ?? this.enableCashOnDelivery,
    );
  }
}
