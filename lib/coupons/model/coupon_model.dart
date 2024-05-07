import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_model.freezed.dart';
part 'coupon_model.g.dart';

@freezed
class CouponModel with _$CouponModel {
  factory CouponModel({
    required int id,
    required String? couponCode,
    required String description,
    required int orders,
    required int amountDiscounted,
    required DateTime created,
    required DateTime expired,
    required CouponType type,
    required bool allowFreeShipping,
    required double minimunSpend,
    required double maximunSpend,
    required List<String>? includeProducts,
    required List<String>? excludeProducts,
    required List<String>? includeCategories,
    required List<String>? excludeCategories,
  }) = _CouponModel;
  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);
}

enum CouponType {
  fixedCartDiscount,
  percentageDiscount,
  fixedProductDiscount,
  empty,
}

class CouponTypeModel extends Equatable {
  final String name;
  final CouponType type;
  const CouponTypeModel({required this.name, required this.type});

  @override
  String toString() {
    return name;
  }

  static const empty = CouponTypeModel(
      name: "Fixed Cart Discount", type: CouponType.fixedCartDiscount);

  @override
  List<Object?> get props => [name, type];
}

const List<CouponTypeModel> couponTypes = [
  CouponTypeModel(
      name: "Fixed Cart Discount", type: CouponType.fixedCartDiscount),
  CouponTypeModel(
      name: "Percentage Discount", type: CouponType.percentageDiscount),
  CouponTypeModel(
      name: "Fixed Product Discount", type: CouponType.fixedProductDiscount),
];
