part of 'coupon_bloc.dart';

class CouponEvent extends BaseEvent {}

class ChangeIncludeProducts extends CouponEvent {
  final Map<String, dynamic> value;
  ChangeIncludeProducts({required this.value});
}

class ChangeExcludeProducts extends CouponEvent {
  final Map<String, dynamic> value;
  ChangeExcludeProducts({required this.value});
}

class ChangeIncludeCategories extends CouponEvent {
  final Map<String, dynamic> value;
  ChangeIncludeCategories({required this.value});
}

class ChangeExcludeCategories extends CouponEvent {
  final Map<String, dynamic> value;
  ChangeExcludeCategories({required this.value});
}

class ChangeCouponCodeEvent extends CouponEvent {
  final String value;
  ChangeCouponCodeEvent({required this.value});
}

class ChangeDescriptionEvent extends CouponEvent {
  final String value;
  ChangeDescriptionEvent({required this.value});
}

class ChangeCouponTypeEvent extends CouponEvent {
  final CouponTypeModel couponType;
  ChangeCouponTypeEvent({required this.couponType});
}

class ChangeAmountEvent extends CouponEvent {
  final String value;
  ChangeAmountEvent({required this.value});
}

class ChangeAllowShipping extends CouponEvent {
  final bool value;
  ChangeAllowShipping({required this.value});
}

class ChangeExpiredDate extends CouponEvent {
  final DateTime value;
  ChangeExpiredDate({required this.value});
}

class ChangeMinimumSpeed extends CouponEvent {
  final int value;
  ChangeMinimumSpeed({required this.value});
}

class ChangeMaximumSpeed extends CouponEvent {
  final int value;
  ChangeMaximumSpeed({required this.value});
}

class ChangeCouponDataTab extends CouponEvent {
  final CouponDataTab tab;
  ChangeCouponDataTab({required this.tab});
}
