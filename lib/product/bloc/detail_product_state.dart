// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_product_bloc.dart';

enum ProductType {
  simpleProduct,
  groupedProduct,
  variableProduct,
}

enum ProductDataTab {
  general,
  inventory,
  shipping,
  linkedProducts,
  attributes,
  variations,
  advanced,
  getMoreOptions,
}

class DetailProductState extends Equatable {
  const DetailProductState({
    this.name,
    this.description,
    this.productShortDescription,
    this.productType,
    this.productDataTab = ProductDataTab.general,
  });
  final String? name;
  final String? description;
  final String? productShortDescription;
  final ProductType? productType;
  final ProductDataTab? productDataTab;

  @override
  List<Object> get props => [
        name ?? "",
        description ?? "",
        productShortDescription ?? "",
        productType ?? "",
        productDataTab ?? "",
      ];

  DetailProductState copyWith({
    String? name,
    String? description,
    String? productShortDescription,
    ProductType? productType,
    ProductDataTab? productDataTab,
  }) {
    return DetailProductState(
      name: name ?? this.name,
      description: description ?? this.description,
      productShortDescription:
          productShortDescription ?? this.productShortDescription,
      productType: productType ?? this.productType,
      productDataTab: productDataTab ?? this.productDataTab,
    );
  }
}
