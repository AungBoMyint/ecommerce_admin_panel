part of 'shipping_bloc.dart';

class ShippingEvent extends BaseEvent {}

class ChangingZoneNameEvent extends ShippingEvent {
  final String name;
  ChangingZoneNameEvent({required this.name});
}

class SelectZoneRegionEvent extends ShippingEvent {
  final String zoneRegion;
  SelectZoneRegionEvent({required this.zoneRegion});
}

class ChangeShippingMethodEvent extends ShippingEvent {
  final String shippingMethod;
  ChangeShippingMethodEvent({required this.shippingMethod});
}

class ChangeShippingCostEvent extends ShippingEvent {
  final int cost;
  ChangeShippingCostEvent({required this.cost});
}

class ChangeShippingTypeEvent extends ShippingEvent {
  final String shippingType;
  ChangeShippingTypeEvent({required this.shippingType});
}
