// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

class CategoryState extends BaseState<AppCategory, CategoryState> {
  final String? selectedParentCategory;
  final RequiredText name;
  final String? displayType;
  final RequiredImage image;
  const CategoryState({
    this.selectedParentCategory,
    this.name = const RequiredText.pure(),
    this.displayType,
    this.image = const RequiredImage.pure(),
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
        selectedParentCategory ?? "",
        name,
        displayType ?? "",
        image,
        ...super.props,
      ];

  @override
  copyWith({
    List<AppCategory>? items,
    editItem,
    int? paginateIndex,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
    String? selectedParentCategory,
    RequiredText? name,
    String? displayType,
    RequiredImage? image,
  }) {
    return CategoryState(
      selectedParentCategory:
          selectedParentCategory ?? this.selectedParentCategory,
      name: name ?? this.name,
      displayType: displayType ?? this.displayType,
      image: image ?? this.image,
      actionStatus: actionStatus ?? this.actionStatus,
      isFirstTimePressed: isFirstTimePressed ?? this.isFirstTimePressed,
      selectedAction: selectedAction ?? this.selectedAction,
      isValid: isValid ?? this.isValid,
      items: items ?? this.items,
      selectedItems: selectedItems ?? this.selectedItems,
      submitStatus: submitStatus ?? this.submitStatus,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      editItem: editItem ?? this.editItem,
    );
  }
}
