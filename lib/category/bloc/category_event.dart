part of 'category_bloc.dart';

abstract class CategoryEvent {
  const CategoryEvent();
}

class PickImageEvent extends CategoryEvent {}

class FetchCategoryEvent extends CategoryEvent {}

class FetchMoreCategoryEvent extends CategoryEvent {}

class SearchCategoryEvent extends CategoryEvent {
  final String? value;
  SearchCategoryEvent({this.value});
}

class DeleteCategoriesEvent extends CategoryEvent {
  final List<String> selectedCategories;
  DeleteCategoriesEvent({required this.selectedCategories});
}

class AddCategoryEvent extends CategoryEvent {
  /* final Category category; */
  AddCategoryEvent(/* {required this.category} */);
}

class UpdateCategoryEvent extends CategoryEvent {
  final Category category;
  UpdateCategoryEvent({required this.category});
}

class ChangeDropDownParentCategory extends CategoryEvent {
  final String value;
  ChangeDropDownParentCategory({required this.value});
}

class ChangeDropDownDisplayType extends CategoryEvent {
  final String value;
  ChangeDropDownDisplayType({required this.value});
}

class ChangeNameEvent extends CategoryEvent {
  final String value;
  ChangeNameEvent({required this.value});
}

class ChangeDropDownActions extends CategoryEvent {
  final String value;
  ChangeDropDownActions({required this.value});
}

class ActionApplyEvent extends CategoryEvent {
  ActionApplyEvent();
}

class ChangeActionStatusEvent extends CategoryEvent {
  ChangeActionStatusEvent({required this.status});
  final ActionStatus status;
}

class SelectAllCategoriesEvent extends CategoryEvent {
  final bool isSelectAll;
  SelectAllCategoriesEvent({this.isSelectAll = false});
}

class SelectCategoryEvent extends CategoryEvent {
  final bool value;
  final int id;
  SelectCategoryEvent({
    required this.value,
    required this.id,
  });
}
