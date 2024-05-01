// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CouponModelImpl _$$CouponModelImplFromJson(Map<String, dynamic> json) =>
    _$CouponModelImpl(
      id: (json['id'] as num).toInt(),
      couponCode: json['couponCode'] as String,
      description: json['description'] as String,
      orders: (json['orders'] as num).toInt(),
      amountDiscounted: json['amountDiscounted'] as String,
      created: DateTime.parse(json['created'] as String),
      expired: DateTime.parse(json['expired'] as String),
      type: $enumDecode(_$CouponTypeEnumMap, json['type']),
      allowFreeShipping: json['allowFreeShipping'] as bool,
      minimunSpend: (json['minimunSpend'] as num).toDouble(),
      maximunSpend: (json['maximunSpend'] as num).toDouble(),
      includeProducts: (json['includeProducts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      excludeProducts: (json['excludeProducts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      includeCategories: (json['includeCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      excludeCategories: (json['excludeCategories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CouponModelImplToJson(_$CouponModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'couponCode': instance.couponCode,
      'description': instance.description,
      'orders': instance.orders,
      'amountDiscounted': instance.amountDiscounted,
      'created': instance.created.toIso8601String(),
      'expired': instance.expired.toIso8601String(),
      'type': _$CouponTypeEnumMap[instance.type]!,
      'allowFreeShipping': instance.allowFreeShipping,
      'minimunSpend': instance.minimunSpend,
      'maximunSpend': instance.maximunSpend,
      'includeProducts': instance.includeProducts,
      'excludeProducts': instance.excludeProducts,
      'includeCategories': instance.includeCategories,
      'excludeCategories': instance.excludeCategories,
    };

const _$CouponTypeEnumMap = {
  CouponType.fixedCartDiscount: 'fixedCartDiscount',
  CouponType.percentageDiscount: 'percentageDiscount',
  CouponType.fixedProductDiscount: 'fixedProductDiscount',
  CouponType.empty: 'empty',
};
