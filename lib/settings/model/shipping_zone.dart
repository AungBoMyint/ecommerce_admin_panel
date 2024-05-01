import 'package:ecommerce_admin/settings/model/shipping_method.dart';

class ShippingZone {
  final int id;
  final String zoneName;
  final List<String> zoneRegions;
  final ShippingMethod shippingMethod;
  ShippingZone({
    required this.id,
    required this.zoneName,
    required this.zoneRegions,
    required this.shippingMethod,
  });
  factory ShippingZone.fromJson(Map<String, dynamic> json) => ShippingZone(
        id: json["id"],
        zoneName: json["zoneName"],
        zoneRegions: (json["zoneRegions"] as List<String>),
        shippingMethod: ShippingMethod.fromJson(json["shippingMethod"]),
      );
}
