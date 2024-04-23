part of 'detail_product_bloc.dart';

abstract class DetailProductEvent {}

class ChangeProductType extends DetailProductEvent {
  final ProductType type;
  ChangeProductType({required this.type});
}

class ChangeProductDataTab extends DetailProductEvent {
  final ProductDataTab dataTab;
  ChangeProductDataTab({required this.dataTab});
}
