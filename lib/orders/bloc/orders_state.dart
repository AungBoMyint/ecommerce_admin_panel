part of 'orders_bloc.dart';

List<String> orderStatusList = [
  "On hold",
  "Failed",
  "Completed",
  "Draft",
  "Cancelled",
  "Pending Payment",
  "Processing",
  "Refunded",
];

List<String> orderPaymentList = [
  "Internet Banking",
  "Installment payments",
  "2Checkout",
  "PayPal",
  "Alipay",
  "SiamPay",
  "Codapay",
  "PromptPay",
];

class OrderState extends BaseState<AppOrder, OrderState> {
  final RequiredInt orderId;
  final RequiredDropdown customerName;
  final String? orderStatus;
  final RequiredObjectList<String> product;
  final RequiredDropdown paymentMethod;
  final RequiredDouble totalAmount;
  final RequiredText shippingAddress;
  final String? filterOrderStatus;
  final String? filterOrderPayment;

  const OrderState({
    this.filterOrderPayment,
    this.filterOrderStatus,
    this.orderId = const RequiredInt.pure(),
    this.customerName = const RequiredDropdown.pure(),
    this.orderStatus,
    this.product = const RequiredObjectList.pure(),
    this.paymentMethod = const RequiredDropdown.pure(),
    this.totalAmount = const RequiredDouble.pure(),
    this.shippingAddress = const RequiredText.pure(),
    super.actionStatus,
    super.isFirstTimePressed,
    super.selectedAction,
    super.isValid,
    super.items,
    super.selectedItems,
    super.submitStatus,
    super.paginateIndex,
    super.editItem,
  });

  @override
  List<Object> get props => [
        orderId,
        customerName,
        orderStatus ?? "",
        product,
        paymentMethod,
        totalAmount,
        shippingAddress,
        filterOrderStatus ?? "",
        filterOrderPayment ?? "",
        ...super.props,
      ];

  @override
  OrderState copyWith({
    List<AppOrder>? items,
    AppOrder? editItem,
    int? paginateIndex,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
    RequiredInt? orderId,
    RequiredDropdown? customerName,
    String? orderStatus,
    RequiredObjectList<String>? product,
    RequiredDropdown? paymentMethod,
    RequiredDouble? totalAmount,
    RequiredText? shippingAddress,
    String? filterOrderStatus,
    String? filterOrderPayment,
  }) {
    return OrderState(
      filterOrderPayment: filterOrderPayment ?? this.filterOrderPayment,
      filterOrderStatus: filterOrderStatus ?? this.filterOrderStatus,
      orderId: orderId ?? this.orderId,
      customerName: customerName ?? this.customerName,
      orderStatus: orderStatus ?? this.orderStatus,
      product: product ?? this.product,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      totalAmount: totalAmount ?? this.totalAmount,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      editItem: editItem ?? this.editItem,
      items: items ?? this.items,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedAction: selectedAction ?? this.selectedAction,
      actionStatus: actionStatus ?? this.actionStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      isValid: isValid ?? this.isValid,
      isFirstTimePressed: isFirstTimePressed ?? this.isFirstTimePressed,
    );
  }
}
