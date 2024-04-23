// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final List<AppCategory> categories;
  final int paginateIndex;
  final String? selectedParentCategory;
  final RequiredText name;
  final String? displayType;
  final RequiredImage image;
  final List<int> selectedCategories;
  final String? selectedAction;
  final ActionStatus actionStatus;
  final FormzSubmissionStatus submitStatus;
  final bool isValid;
  final bool isFirstTimePressed;
  const CategoryState({
    this.selectedAction,
    this.isFirstTimePressed = false,
    this.submitStatus = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.selectedCategories = const [],
    this.categories = const [],
    this.paginateIndex = 20,
    this.selectedParentCategory,
    this.name = const RequiredText.pure(),
    this.displayType,
    this.image = const RequiredImage.pure(),
    this.actionStatus = ActionStatus.initial,
  });

  @override
  List<Object?> get props => [
        selectedCategories,
        selectedAction,
        isFirstTimePressed,
        categories,
        paginateIndex,
        selectedParentCategory,
        name,
        displayType,
        image,
        actionStatus,
      ];

  CategoryState copyWith({
    List<AppCategory>? categories,
    String? selectedAction,
    int? paginateIndex,
    String? selectedParentCategory,
    RequiredText? name,
    String? displayType,
    RequiredImage? image,
    List<int>? selectedCategories,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
  }) {
    return CategoryState(
      isFirstTimePressed: isFirstTimePressed ?? this.isFirstTimePressed,
      selectedAction: selectedAction ?? this.selectedAction,
      categories: categories ?? this.categories,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      selectedParentCategory:
          selectedParentCategory ?? this.selectedParentCategory,
      name: name ?? this.name,
      displayType: displayType ?? this.displayType,
      image: image ?? this.image,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      actionStatus: actionStatus ?? this.actionStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      isValid: isValid ?? this.isValid,
    );
  }
}
