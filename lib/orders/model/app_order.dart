class AppOrder {
  final int id;
  final String customerName;
  final String orderStatus;
  final String product;
  final double totalAmount;
  final String shippingAddress;
  final String paymentMethods;
  AppOrder({
    required this.id,
    required this.customerName,
    required this.orderStatus,
    required this.product,
    required this.totalAmount,
    required this.shippingAddress,
    required this.paymentMethods,
  });

  factory AppOrder.fromJson(Map<String, dynamic> json) => AppOrder(
        id: json["id"],
        customerName: json["customerName"],
        orderStatus: json["orderStatus"],
        product: json["product"],
        totalAmount: json["totalAmount"],
        shippingAddress: json["shippingAddress"],
        paymentMethods: json["paymentMethods"],
      );
}
