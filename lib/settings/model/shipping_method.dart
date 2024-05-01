enum Shipping {
  flat,
  free,
  local,
}

enum FreeShippingType {
  validCoupon,
  minumunOrder,
  minumunOrderORCoupon,
  minumunOrderANDCoupon,
  empty,
}

Shipping stringToShipping(String value) {
  if (value.toLowerCase().startsWith("fl")) {
    return Shipping.flat;
  } else if (value.toLowerCase().startsWith("fr")) {
    return Shipping.free;
  } else {
    return Shipping.local;
  }
}

FreeShippingType stringToFreeShipping(String value) {
  switch (value) {
    case "A valid free shipping coupon":
      return FreeShippingType.validCoupon;
    case "A minumun order amount":
      return FreeShippingType.minumunOrder;
    case "A minumun order amount OR a coupon":
      return FreeShippingType.minumunOrderORCoupon;
    case "A minumun order amount AND a coupon":
      return FreeShippingType.minumunOrderANDCoupon;
    default:
      return FreeShippingType.empty;
  }
}

String? freeShippingToString(FreeShippingType type) {
  switch (type) {
    case FreeShippingType.validCoupon:
      return "A valid free shipping coupon";
    case FreeShippingType.minumunOrder:
      return "A minumun order amount";
    case FreeShippingType.minumunOrderORCoupon:
      return "A minumun order amount OR a coupon";
    case FreeShippingType.minumunOrderANDCoupon:
      return "A minumun order amount AND a coupon";
    default:
      return null;
  }
}

class ShippingMethod {
  final String name;
  final Shipping shipping;
  final int? cost;
  final FreeShippingType? type;
  ShippingMethod({
    required this.name,
    required this.shipping,
    this.cost,
    this.type,
  });
  factory ShippingMethod.fromJson(Map<String, dynamic> json) => ShippingMethod(
        name: json["name"],
        shipping: stringToShipping(json["name"]),
        cost: json["cost"],
        type: stringToFreeShipping(json["type"]),
      );
}

List<ShippingMethod> shippingMethods = [
  ShippingMethod(
    name: "Flat rate",
    shipping: Shipping.flat,
  ),
  ShippingMethod(
    name: "Free shipping",
    shipping: Shipping.free,
  ),
  ShippingMethod(
    name: "Local pickup",
    shipping: Shipping.local,
  ),
];
