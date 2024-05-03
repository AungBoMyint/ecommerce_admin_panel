part of 'category_bloc.dart';

class CategoryEvent extends BaseEvent {}

class PickImageEvent extends CategoryEvent {}

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
