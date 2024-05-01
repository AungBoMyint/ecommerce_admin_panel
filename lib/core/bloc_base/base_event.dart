part of 'base_bloc.dart';

class FetchEvent extends BaseEvent /* ReviewEvent */ {}

class FetchMoreEvent extends BaseEvent /* ReviewEvent */ {}

class FilterEvent extends BaseEvent /* ReviewEvent */ {}

class SearchEvent extends BaseEvent /* ReviewEvent */ {
  final String? value;
  SearchEvent({this.value});
}

class DeleteEvent extends BaseEvent /* ReviewEvent */ {}

class AddEvent extends BaseEvent /* ReviewEvent */ {}

class UpdateEvent extends BaseEvent /* ReviewEvent */ {}

class ChangeActionsEvent extends BaseEvent /* ReviewEvent */ {
  final String value;
  ChangeActionsEvent({required this.value});
}

class ActionApplyEvent extends BaseEvent /* ReviewEvent */ {}

class ChangeActionsStatusEvent extends BaseEvent /* ReviewEvent */ {
  final ActionStatus status;
  ChangeActionsStatusEvent({required this.status});
}

class SelectItemEvent extends BaseEvent /* ReviewEvent */ {
  final bool value;
  final int id;
  SelectItemEvent({required this.value, required this.id});
}

class SelectAllItemsEvent extends BaseEvent /* ReviewEvent */ {
  final bool isSelectAll;
  SelectAllItemsEvent({required this.isSelectAll});
}

class SetEditItemEvent<T> extends BaseEvent {
  final T item;
  SetEditItemEvent({required this.item});
}

abstract class BaseEvent {
  BaseEvent();
}
