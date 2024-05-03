// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

class ProductState extends BaseState<Product, ProductState> {
  final String selectedCategory;
  final String produtType;
  final String stockStatus;
  const ProductState({
    this.selectedCategory = "",
    this.produtType = "",
    this.stockStatus = "",
    super.actionStatus,
    super.isFirstTimePressed,
    super.selectedAction,
    super.isValid,
    super.items,
    super.selectedItems,
    super.submitStatus,
    super.paginateIndex,
    super.editItem,
  });

  @override
  List<Object> get props => [
        paginateIndex,
        selectedCategory,
        produtType,
        stockStatus,
        actionStatus,
        ...super.props,
      ];

  @override
  ProductState copyWith({
    List<Product>? items,
    Product? editItem,
    int? paginateIndex,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
    String? selectedCategory,
    String? produtType,
    String? stockStatus,
  }) {
    return ProductState(
      items: items ?? this.items,
      editItem: editItem ?? this.editItem,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedAction: selectedAction ?? this.selectedAction,
      actionStatus: actionStatus ?? this.actionStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      isValid: isValid ?? this.isValid,
      isFirstTimePressed: isFirstTimePressed ?? this.isFirstTimePressed,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      produtType: produtType ?? this.produtType,
      stockStatus: stockStatus ?? this.stockStatus,
    );
  }
}
