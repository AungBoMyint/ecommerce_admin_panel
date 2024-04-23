import 'package:ecommerce_admin/product/bloc/detail_product_bloc.dart';

String? getProductType(ProductType? productType) {
  switch (productType) {
    case ProductType.simpleProduct:
      return "Simple Product";
    case ProductType.groupedProduct:
      return "Grouped Product";
    case ProductType.variableProduct:
      return "Variable Product";
    default:
      return "Simple Product";
  }
}

ProductType getProductTypeString(String? productType) {
  switch (productType) {
    case "Simple Product":
      return ProductType.simpleProduct;
    case "Grouped Product":
      return ProductType.groupedProduct;
    case "Variable Product":
      return ProductType.variableProduct;
    default:
      return ProductType.simpleProduct;
  }
}
