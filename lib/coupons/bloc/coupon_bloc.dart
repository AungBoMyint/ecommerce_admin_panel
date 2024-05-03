// ignore_for_file: implementation_imports

import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/src/bloc.dart';
import 'package:ecommerce_admin/core/formz/fromz_class.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/coupons/model/coupon_model.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends BaseBloc<CouponModel, BaseEvent, CouponState> {
  CouponBloc() : super(const CouponState()) {
    on<ChangeCouponCodeEvent>(_onChangeCouponCode);
    on<ChangeDescriptionEvent>(_onChangeDescription);
    on<ChangeCouponDataTab>(_onChangeCouponDataTab);
    on<ChangeCouponTypeEvent>(_onChangeCouponType);
    on<ChangeAmountEvent>(_onChangeAmount);
    on<ChangeAllowShipping>(_onChangeAllowShipping);
    on<ChangeExpiredDate>(_onChangeExpireDate);
    on<ChangeMinimumSpeed>(_onChangeMinimumSpeed);
    on<ChangeMaximumSpeed>(_onChangeMaximumSpeed);
    on<ChangeIncludeProducts>(_onChangeIncludeProducts);
    on<ChangeExcludeProducts>(_onChangeExcludeProducts);
    on<ChangeIncludeCategories>(_onChangeIncludeCategories);
    on<ChangeExcludeCategories>(_onChangeExcludeCategories);
  }

  @override
  bool checkItemById(CouponModel item, int id) {
    return item.id == id;
  }

  @override
  int getId(e) {
    return e.id;
  }

  @override
  PageType getPageType() {
    return PageType.editCoupons;
  }

  @override
  CouponModel parseFromJson(e) {
    return CouponModel.fromJson(e);
  }

  @override
  Future<String> requestData() async {
    return "";
  }

  FutureOr<void> _onChangeCouponCode(
      ChangeCouponCodeEvent event, Emitter<CouponState> emit) {
    final code = RequiredText.dirty(value: event.value);
    emit(state.copyWith(
      couponCode: code,
      isValid: Formz.validate([
        code,
        state.couponType,
        state.amount,
        state.expireDate,
      ]),
    ));
  }

  FutureOr<void> _onChangeDescription(
      ChangeDescriptionEvent event, Emitter<CouponState> emit) {
    emit(state.copyWith(description: event.value));
  }

  FutureOr<void> _onChangeCouponDataTab(
      ChangeCouponDataTab event, Emitter<CouponState> emit) {
    emit(state.copyWith(dataTab: event.tab));
  }

  FutureOr<void> _onChangeCouponType(
      ChangeCouponTypeEvent event, Emitter<CouponState> emit) {
    final couponType =
        RequiredObject<CouponTypeModel>.dirty(value: event.couponType);
    emit(state.copyWith(
        couponType: couponType,
        isValid: Formz.validate([
          state.couponCode,
          couponType,
          state.amount,
          state.expireDate,
        ])));
  }

  FutureOr<void> _onChangeAmount(
      ChangeAmountEvent event, Emitter<CouponState> emit) {
    final amount = RequiredText.dirty(value: event.value);
    emit(state.copyWith(
        amount: amount,
        isValid: Formz.validate([
          amount,
          state.couponType,
          state.couponCode,
          state.expireDate,
        ])));
  }

  FutureOr<void> _onChangeAllowShipping(
      ChangeAllowShipping event, Emitter<CouponState> emit) {
    emit(state.copyWith(allowFreeShipping: event.value));
  }

  FutureOr<void> _onChangeExpireDate(
      ChangeExpiredDate event, Emitter<CouponState> emit) {
    final expired = RequiredObject<DateTime>.dirty(value: event.value);
    emit(state.copyWith(
        expireDate: expired,
        isValid: Formz.validate([
          expired,
          state.couponType,
          state.couponCode,
          state.amount,
        ])));
  }

  FutureOr<void> _onChangeMinimumSpeed(
      ChangeMinimumSpeed event, Emitter<CouponState> emit) {
    emit(state.copyWith(minumumSpend: event.value));
  }

  FutureOr<void> _onChangeMaximumSpeed(
      ChangeMaximumSpeed event, Emitter<CouponState> emit) {
    emit(state.copyWith(maximumSpend: event.value));
  }

  FutureOr<void> _onChangeIncludeProducts(
      ChangeIncludeProducts event, Emitter<CouponState> emit) {
    List<Map<String, dynamic>> list = List.from(state.includeProducts);
    if (state.includeProducts.contains(event.value)) {
      //already contains,so remove it
      list.remove(event.value);
    } else {
      list.add(event.value);
    }
    emit(state.copyWith(includeProducts: list));
  }

  FutureOr<void> _onChangeExcludeProducts(
      ChangeExcludeProducts event, Emitter<CouponState> emit) {
    List<Map<String, dynamic>> list = List.from(state.excludeProducts);
    if (state.excludeProducts.contains(event.value)) {
      //already contains,so remove it
      list.remove(event.value);
    } else {
      list.add(event.value);
    }
    emit(state.copyWith(excludeProducts: list));
  }

  FutureOr<void> _onChangeIncludeCategories(
      ChangeIncludeCategories event, Emitter<CouponState> emit) {
    List<Map<String, dynamic>> list = List.from(state.includeCategories);
    if (state.includeCategories.contains(event.value)) {
      //already contains,so remove it
      list.remove(event.value);
    } else {
      list.add(event.value);
    }
    emit(state.copyWith(includeCategories: list));
  }

  FutureOr<void> _onChangeExcludeCategories(
      ChangeExcludeCategories event, Emitter<CouponState> emit) {
    List<Map<String, dynamic>> list = List.from(state.excludeCategories);
    if (state.excludeCategories.contains(event.value)) {
      //already contains,so remove it
      list.remove(event.value);
    } else {
      list.add(event.value);
    }
    emit(state.copyWith(excludeCategories: list));
  }
}
