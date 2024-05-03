part of 'product_bloc.dart';

class ProductEvent extends BaseEvent {}

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
