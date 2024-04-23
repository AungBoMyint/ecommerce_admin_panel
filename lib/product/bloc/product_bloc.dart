import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/product/model/product.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/data/actions_status.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<FetchProductEvent>(_onFetchProduct);
    on<FetchMoreProductEvent>(_onFetchMoreProduct);
    on<ChangeDropDownCategory>(_onChangeDropDownCategory);
    on<ChangeDropDownProductType>(_onChangeDropDownProductType);
    on<ChangeDropDownStockStatus>(_onChangeDropDownStockStatus);
    on<FilterProductEvent>(_onFilterProduct);
    on<SearchProductEvent>(_onSearchProduct);
    on<SelectAllProductsEvent>(_onSelectAllProducts);
    on<SelectProductEvent>(_onSelectProduct);
    on<ChangeDropDownActions>(_onChangeDropDownActions);
    on<ActionApplyEvent>(_onActionApply);
    on<ChangeActionStatusEvent>(_onChangeActionStatus);
  }

  FutureOr<void> _onFetchProduct(
      FetchProductEvent event, Emitter<ProductState> emit) async {
    if (state.fetching) {
      return;
    }
    emit(state.copyWith(fetching: true));
    //fetching products data
    final productsJson =
        await rootBundle.loadString("assets/mock/product_mock.json");
    final List<dynamic> results = jsonDecode(productsJson);
    var products = results.map((e) => Product.fromJson(e)).toList();
    products.removeRange(state.paginateIndex, 1000);
    emit(state.copyWith(fetching: false, products: products));
  }

  FutureOr<void> _onFetchMoreProduct(
      FetchMoreProductEvent event, Emitter<ProductState> emit) async {
    if (state.fetching) {
      return;
    }
    emit(state.copyWith(fetching: true));
    //fetching products data
    final productsJson =
        await rootBundle.loadString("assets/mock/product_mock.json");
    final List<dynamic> results = jsonDecode(productsJson);
    var products = results.map((e) => Product.fromJson(e)).toList();
    products.removeRange(state.paginateIndex * 2, 1000);
    emit(state.copyWith(
        fetching: false,
        products: products,
        paginateIndex: state.paginateIndex * 2));
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

  FutureOr<void> _onFilterProduct(
      FilterProductEvent event, Emitter<ProductState> emit) async {
    if (state.fetching) return;
    emit(state.copyWith(fetching: true));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(fetching: false));
  }

  FutureOr<void> _onSearchProduct(
      SearchProductEvent event, Emitter<ProductState> emit) async {
    if (state.fetching) return;
    emit(state.copyWith(fetching: true));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(fetching: false));
  }

  FutureOr<void> _onSelectAllProducts(
      SelectAllProductsEvent event, Emitter<ProductState> emit) async {
    if (event.isSelectAll) {
      emit(state.copyWith(
          selectedProducts: state.products.map((e) => e.id).toList()));
    } else {
      emit(state.copyWith(selectedProducts: []));
    }
  }

  FutureOr<void> _onSelectProduct(
      SelectProductEvent event, Emitter<ProductState> emit) {
    if (event.value) {
      //means this is select
      List<int> list = List.from(state.selectedProducts);
      list.add(event.id);
      emit(state.copyWith(selectedProducts: list));
    } else {
      //not select
      List<int> list = List.from(state.selectedProducts);
      list.remove(event.id);
      emit(state.copyWith(selectedProducts: list));
    }
  }

  FutureOr<void> _onChangeDropDownActions(
      ChangeDropDownActions event, Emitter<ProductState> emit) {
    emit(state.copyWith(selectedAction: event.value));
  }

  FutureOr<void> _onActionApply(
      ActionApplyEvent event, Emitter<ProductState> emit) async {
    //we can only apply delete if selected one or more product.
    if (state.selectedAction == "Delete" && state.selectedProducts.isNotEmpty) {
      //memic request deleting to SERVER.
      List<Product> list = await Future.delayed(const Duration(seconds: 1), () {
        List<Product> list = List.from(state.products);
        for (var id in state.selectedProducts) {
          list.removeWhere((element) => element.id == id);
        }
        return list;
      });
      emit(
        state.copyWith(
          products: list,
          selectedProducts: [],
          actionStatus: ActionStatus.deletingSuccess,
        ),
      );
      return;
    }
    //we can only apply edit if selected only one product.
    if (state.selectedAction == "Edit") {
      if (state.selectedProducts.length > 1) {
        //can't edit multiple,please select one item
        log("Can't edit multiple,please select one item ");
        ScaffoldMessenger.of(navigatorKey.currentContext!)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
              "Oops!Can't edit multiple items,please select only one & try again.",
              style: Theme.of(navigatorKey.currentContext!)
                  .textTheme
                  .displayMedium
                  ?.copyWith(
                    color: Colors.red,
                  ),
            ),
          ));
      } else if (state.selectedProducts.length == 1) {
        //can edit
        navigatorKey.currentContext?.read<CoreBloc>().add(
              ChangePageEvent(page: PageType.editProduct),
            );

        add(
          ChangeActionStatusEvent(status: ActionStatus.initial),
        );
      }
    }
  }

  FutureOr<void> _onChangeActionStatus(
      ChangeActionStatusEvent event, Emitter<ProductState> emit) {
    emit(state.copyWith(actionStatus: event.status));
  }
}
