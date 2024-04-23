// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<Product> products;
  final bool fetching;
  final bool fetchingMore;
  final int paginateIndex;
  final String selectedCategory;
  final String produtType;
  final String stockStatus;
  final String selectedAction;
  final List<int> selectedProducts;
  final ActionStatus actionStatus;
  const ProductState({
    this.selectedProducts = const [],
    this.products = const [],
    this.fetching = false,
    this.fetchingMore = false,
    this.paginateIndex = 20,
    this.selectedCategory = "",
    this.produtType = "",
    this.stockStatus = "",
    this.selectedAction = "",
    this.actionStatus = ActionStatus.initial,
  });

  @override
  List<Object> get props => [
        products,
        fetching,
        fetchingMore,
        paginateIndex,
        selectedCategory,
        produtType,
        stockStatus,
        selectedProducts,
        selectedAction,
        actionStatus,
      ];

  ProductState copyWith({
    List<Product>? products,
    bool? fetching,
    bool? fetchingMore,
    int? paginateIndex,
    String? selectedCategory,
    String? produtType,
    String? stockStatus,
    List<int>? selectedProducts,
    String? selectedAction,
    ActionStatus? actionStatus,
  }) {
    return ProductState(
      products: products ?? this.products,
      fetching: fetching ?? this.fetching,
      fetchingMore: fetchingMore ?? this.fetchingMore,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      produtType: produtType ?? this.produtType,
      stockStatus: stockStatus ?? this.stockStatus,
      selectedProducts: selectedProducts ?? this.selectedProducts,
      selectedAction: selectedAction ?? this.selectedAction,
      actionStatus: actionStatus ?? this.actionStatus,
    );
  }
}
