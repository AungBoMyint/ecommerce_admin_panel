import 'dart:async';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';

import 'package:ecommerce_admin/product/model/product.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../core/data/actions_status.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BaseBloc<Product, BaseEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<ChangeDropDownCategory>(_onChangeDropDownCategory);
    on<ChangeDropDownProductType>(_onChangeDropDownProductType);
    on<ChangeDropDownStockStatus>(_onChangeDropDownStockStatus);
  }

  FutureOr<void> _onChangeDropDownCategory(
      ChangeDropDownCategory event, Emitter<ProductState> emit) {
    emit(state.copyWith(selectedCategory: event.value));
  }

  FutureOr<void> _onChangeDropDownProductType(
      ChangeDropDownProductType event, Emitter<ProductState> emit) {
    emit(state.copyWith(produtType: event.value));
  }

  FutureOr<void> _onChangeDropDownStockStatus(
      ChangeDropDownStockStatus event, Emitter<ProductState> emit) {
    emit(state.copyWith(stockStatus: event.value));
  }

  @override
  bool checkItemById(Product item, int id) {
    return item.id == id;
  }

  @override
  int getId(e) {
    return e.id;
  }

  @override
  PageType getPageType() {
    return PageType.editProduct;
  }

  @override
  Product parseFromJson(e) {
    return Product.fromJson(e);
  }

  @override
  Future<String> requestData() async {
    return await rootBundle.loadString("assets/mock/product_mock.json");
  }
}
