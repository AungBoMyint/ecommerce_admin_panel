part of 'product_bloc.dart';

class ProductEvent {}

class FetchProductEvent extends ProductEvent {}

class FetchMoreProductEvent extends ProductEvent {}

class FilterProductEvent extends ProductEvent {
  final String? category;
  final String? productType;
  final String? stockStatus;
  FilterProductEvent({this.category, this.productType, this.stockStatus});
}

class SearchProductEvent extends ProductEvent {
  final String? value;
  SearchProductEvent({this.value});
}

class DeleteProductsEvent extends ProductEvent {
  final List<String> selectedProducts;
  DeleteProductsEvent({required this.selectedProducts});
}

class AddProductEvent extends ProductEvent {
  final Product product;
  AddProductEvent({required this.product});
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  UpdateProductEvent({required this.product});
}

class ChangeDropDownCategory extends ProductEvent {
  final String value;
  ChangeDropDownCategory({required this.value});
}

class ChangeDropDownProductType extends ProductEvent {
  final String value;
  ChangeDropDownProductType({required this.value});
}

class ChangeDropDownStockStatus extends ProductEvent {
  final String value;
  ChangeDropDownStockStatus({required this.value});
}

class ChangeDropDownActions extends ProductEvent {
  final String value;
  ChangeDropDownActions({required this.value});
}

class ActionApplyEvent extends ProductEvent {
  ActionApplyEvent();
}

class ChangeActionStatusEvent extends ProductEvent {
  ChangeActionStatusEvent({required this.status});
  final ActionStatus status;
}

class SelectAllProductsEvent extends ProductEvent {
  final bool isSelectAll;
  SelectAllProductsEvent({this.isSelectAll = false});
}

class SelectProductEvent extends ProductEvent {
  final bool value;
  final int id;
  SelectProductEvent({
    required this.value,
    required this.id,
  });
}
