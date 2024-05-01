// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_bloc.dart';

class ReviewState extends BaseState<AppReview, ReviewState> {
  //-----form variables-----//
  final RequiredText review;
  final RequiredDouble rating;
  final RequiredDropdown product;
  final RequiredDropdown author;
  //------endform----------//
  const ReviewState({
    this.review = const RequiredText.pure(),
    this.rating = const RequiredDouble.pure(),
    this.product = const RequiredDropdown.pure(),
    this.author = const RequiredDropdown.pure(),
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
        review,
        rating,
        product,
        author,
        ...super.props,
      ];
  @override
  ReviewState copyWith({
    AppReview? editItem,
    List<AppReview>? items,
    int? paginateIndex,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
    RequiredText? review,
    RequiredDouble? rating,
    RequiredDropdown? product,
    RequiredDropdown? author,
  }) {
    return ReviewState(
      editItem: editItem ?? this.editItem,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      product: product ?? this.product,
      author: author ?? this.author,
      items: items ?? this.items,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedAction: selectedAction ?? this.selectedAction,
      actionStatus: actionStatus ?? this.actionStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      isValid: isValid ?? this.isValid,
      isFirstTimePressed: isFirstTimePressed ?? this.isFirstTimePressed,
    );
  }
}
