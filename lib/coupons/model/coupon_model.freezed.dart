// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CouponModel _$CouponModelFromJson(Map<String, dynamic> json) {
  return _CouponModel.fromJson(json);
}

/// @nodoc
mixin _$CouponModel {
  int get id => throw _privateConstructorUsedError;
  String get couponCode => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get orders => throw _privateConstructorUsedError;
  String get amountDiscounted => throw _privateConstructorUsedError;
  DateTime get created => throw _privateConstructorUsedError;
  DateTime get expired => throw _privateConstructorUsedError;
  CouponType get type => throw _privateConstructorUsedError;
  bool get allowFreeShipping => throw _privateConstructorUsedError;
  double get minimunSpend => throw _privateConstructorUsedError;
  double get maximunSpend => throw _privateConstructorUsedError;
  List<String> get includeProducts => throw _privateConstructorUsedError;
  List<String> get excludeProducts => throw _privateConstructorUsedError;
  List<String> get includeCategories => throw _privateConstructorUsedError;
  List<String> get excludeCategories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CouponModelCopyWith<CouponModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CouponModelCopyWith<$Res> {
  factory $CouponModelCopyWith(
          CouponModel value, $Res Function(CouponModel) then) =
      _$CouponModelCopyWithImpl<$Res, CouponModel>;
  @useResult
  $Res call(
      {int id,
      String couponCode,
      String description,
      int orders,
      String amountDiscounted,
      DateTime created,
      DateTime expired,
      CouponType type,
      bool allowFreeShipping,
      double minimunSpend,
      double maximunSpend,
      List<String> includeProducts,
      List<String> excludeProducts,
      List<String> includeCategories,
      List<String> excludeCategories});
}

/// @nodoc
class _$CouponModelCopyWithImpl<$Res, $Val extends CouponModel>
    implements $CouponModelCopyWith<$Res> {
  _$CouponModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? couponCode = null,
    Object? description = null,
    Object? orders = null,
    Object? amountDiscounted = null,
    Object? created = null,
    Object? expired = null,
    Object? type = null,
    Object? allowFreeShipping = null,
    Object? minimunSpend = null,
    Object? maximunSpend = null,
    Object? includeProducts = null,
    Object? excludeProducts = null,
    Object? includeCategories = null,
    Object? excludeCategories = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      couponCode: null == couponCode
          ? _value.couponCode
          : couponCode // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as int,
      amountDiscounted: null == amountDiscounted
          ? _value.amountDiscounted
          : amountDiscounted // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expired: null == expired
          ? _value.expired
          : expired // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CouponType,
      allowFreeShipping: null == allowFreeShipping
          ? _value.allowFreeShipping
          : allowFreeShipping // ignore: cast_nullable_to_non_nullable
              as bool,
      minimunSpend: null == minimunSpend
          ? _value.minimunSpend
          : minimunSpend // ignore: cast_nullable_to_non_nullable
              as double,
      maximunSpend: null == maximunSpend
          ? _value.maximunSpend
          : maximunSpend // ignore: cast_nullable_to_non_nullable
              as double,
      includeProducts: null == includeProducts
          ? _value.includeProducts
          : includeProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludeProducts: null == excludeProducts
          ? _value.excludeProducts
          : excludeProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      includeCategories: null == includeCategories
          ? _value.includeCategories
          : includeCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludeCategories: null == excludeCategories
          ? _value.excludeCategories
          : excludeCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CouponModelImplCopyWith<$Res>
    implements $CouponModelCopyWith<$Res> {
  factory _$$CouponModelImplCopyWith(
          _$CouponModelImpl value, $Res Function(_$CouponModelImpl) then) =
      __$$CouponModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String couponCode,
      String description,
      int orders,
      String amountDiscounted,
      DateTime created,
      DateTime expired,
      CouponType type,
      bool allowFreeShipping,
      double minimunSpend,
      double maximunSpend,
      List<String> includeProducts,
      List<String> excludeProducts,
      List<String> includeCategories,
      List<String> excludeCategories});
}

/// @nodoc
class __$$CouponModelImplCopyWithImpl<$Res>
    extends _$CouponModelCopyWithImpl<$Res, _$CouponModelImpl>
    implements _$$CouponModelImplCopyWith<$Res> {
  __$$CouponModelImplCopyWithImpl(
      _$CouponModelImpl _value, $Res Function(_$CouponModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? couponCode = null,
    Object? description = null,
    Object? orders = null,
    Object? amountDiscounted = null,
    Object? created = null,
    Object? expired = null,
    Object? type = null,
    Object? allowFreeShipping = null,
    Object? minimunSpend = null,
    Object? maximunSpend = null,
    Object? includeProducts = null,
    Object? excludeProducts = null,
    Object? includeCategories = null,
    Object? excludeCategories = null,
  }) {
    return _then(_$CouponModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      couponCode: null == couponCode
          ? _value.couponCode
          : couponCode // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      orders: null == orders
          ? _value.orders
          : orders // ignore: cast_nullable_to_non_nullable
              as int,
      amountDiscounted: null == amountDiscounted
          ? _value.amountDiscounted
          : amountDiscounted // ignore: cast_nullable_to_non_nullable
              as String,
      created: null == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expired: null == expired
          ? _value.expired
          : expired // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CouponType,
      allowFreeShipping: null == allowFreeShipping
          ? _value.allowFreeShipping
          : allowFreeShipping // ignore: cast_nullable_to_non_nullable
              as bool,
      minimunSpend: null == minimunSpend
          ? _value.minimunSpend
          : minimunSpend // ignore: cast_nullable_to_non_nullable
              as double,
      maximunSpend: null == maximunSpend
          ? _value.maximunSpend
          : maximunSpend // ignore: cast_nullable_to_non_nullable
              as double,
      includeProducts: null == includeProducts
          ? _value._includeProducts
          : includeProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludeProducts: null == excludeProducts
          ? _value._excludeProducts
          : excludeProducts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      includeCategories: null == includeCategories
          ? _value._includeCategories
          : includeCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      excludeCategories: null == excludeCategories
          ? _value._excludeCategories
          : excludeCategories // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CouponModelImpl implements _CouponModel {
  _$CouponModelImpl(
      {required this.id,
      required this.couponCode,
      required this.description,
      required this.orders,
      required this.amountDiscounted,
      required this.created,
      required this.expired,
      required this.type,
      required this.allowFreeShipping,
      required this.minimunSpend,
      required this.maximunSpend,
      required final List<String> includeProducts,
      required final List<String> excludeProducts,
      required final List<String> includeCategories,
      required final List<String> excludeCategories})
      : _includeProducts = includeProducts,
        _excludeProducts = excludeProducts,
        _includeCategories = includeCategories,
        _excludeCategories = excludeCategories;

  factory _$CouponModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CouponModelImplFromJson(json);

  @override
  final int id;
  @override
  final String couponCode;
  @override
  final String description;
  @override
  final int orders;
  @override
  final String amountDiscounted;
  @override
  final DateTime created;
  @override
  final DateTime expired;
  @override
  final CouponType type;
  @override
  final bool allowFreeShipping;
  @override
  final double minimunSpend;
  @override
  final double maximunSpend;
  final List<String> _includeProducts;
  @override
  List<String> get includeProducts {
    if (_includeProducts is EqualUnmodifiableListView) return _includeProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_includeProducts);
  }

  final List<String> _excludeProducts;
  @override
  List<String> get excludeProducts {
    if (_excludeProducts is EqualUnmodifiableListView) return _excludeProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_excludeProducts);
  }

  final List<String> _includeCategories;
  @override
  List<String> get includeCategories {
    if (_includeCategories is EqualUnmodifiableListView)
      return _includeCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_includeCategories);
  }

  final List<String> _excludeCategories;
  @override
  List<String> get excludeCategories {
    if (_excludeCategories is EqualUnmodifiableListView)
      return _excludeCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_excludeCategories);
  }

  @override
  String toString() {
    return 'CouponModel(id: $id, couponCode: $couponCode, description: $description, orders: $orders, amountDiscounted: $amountDiscounted, created: $created, expired: $expired, type: $type, allowFreeShipping: $allowFreeShipping, minimunSpend: $minimunSpend, maximunSpend: $maximunSpend, includeProducts: $includeProducts, excludeProducts: $excludeProducts, includeCategories: $includeCategories, excludeCategories: $excludeCategories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CouponModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.couponCode, couponCode) ||
                other.couponCode == couponCode) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.orders, orders) || other.orders == orders) &&
            (identical(other.amountDiscounted, amountDiscounted) ||
                other.amountDiscounted == amountDiscounted) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.expired, expired) || other.expired == expired) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.allowFreeShipping, allowFreeShipping) ||
                other.allowFreeShipping == allowFreeShipping) &&
            (identical(other.minimunSpend, minimunSpend) ||
                other.minimunSpend == minimunSpend) &&
            (identical(other.maximunSpend, maximunSpend) ||
                other.maximunSpend == maximunSpend) &&
            const DeepCollectionEquality()
                .equals(other._includeProducts, _includeProducts) &&
            const DeepCollectionEquality()
                .equals(other._excludeProducts, _excludeProducts) &&
            const DeepCollectionEquality()
                .equals(other._includeCategories, _includeCategories) &&
            const DeepCollectionEquality()
                .equals(other._excludeCategories, _excludeCategories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      couponCode,
      description,
      orders,
      amountDiscounted,
      created,
      expired,
      type,
      allowFreeShipping,
      minimunSpend,
      maximunSpend,
      const DeepCollectionEquality().hash(_includeProducts),
      const DeepCollectionEquality().hash(_excludeProducts),
      const DeepCollectionEquality().hash(_includeCategories),
      const DeepCollectionEquality().hash(_excludeCategories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CouponModelImplCopyWith<_$CouponModelImpl> get copyWith =>
      __$$CouponModelImplCopyWithImpl<_$CouponModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CouponModelImplToJson(
      this,
    );
  }
}

abstract class _CouponModel implements CouponModel {
  factory _CouponModel(
      {required final int id,
      required final String couponCode,
      required final String description,
      required final int orders,
      required final String amountDiscounted,
      required final DateTime created,
      required final DateTime expired,
      required final CouponType type,
      required final bool allowFreeShipping,
      required final double minimunSpend,
      required final double maximunSpend,
      required final List<String> includeProducts,
      required final List<String> excludeProducts,
      required final List<String> includeCategories,
      required final List<String> excludeCategories}) = _$CouponModelImpl;

  factory _CouponModel.fromJson(Map<String, dynamic> json) =
      _$CouponModelImpl.fromJson;

  @override
  int get id;
  @override
  String get couponCode;
  @override
  String get description;
  @override
  int get orders;
  @override
  String get amountDiscounted;
  @override
  DateTime get created;
  @override
  DateTime get expired;
  @override
  CouponType get type;
  @override
  bool get allowFreeShipping;
  @override
  double get minimunSpend;
  @override
  double get maximunSpend;
  @override
  List<String> get includeProducts;
  @override
  List<String> get excludeProducts;
  @override
  List<String> get includeCategories;
  @override
  List<String> get excludeCategories;
  @override
  @JsonKey(ignore: true)
  _$$CouponModelImplCopyWith<_$CouponModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
