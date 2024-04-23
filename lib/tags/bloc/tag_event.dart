part of 'tag_bloc.dart';

abstract class TagEvent {
  const TagEvent();
}

class FetchTagEvent extends TagEvent {}

class FetchMoreTagEvent extends TagEvent {}

class SearchTagEvent extends TagEvent {
  final String? value;
  SearchTagEvent({this.value});
}

class DeleteTagsEvent extends TagEvent {
  final List<String> selectedTags;
  DeleteTagsEvent({required this.selectedTags});
}

class AddTagEvent extends TagEvent {
  /* final Tag Tag; */
  AddTagEvent(/* {required this.category} */);
}

class UpdateTagEvent extends TagEvent {
  final AppTag tag;
  UpdateTagEvent({required this.tag});
}

class ChangeNameEvent extends TagEvent {
  final String value;
  ChangeNameEvent({required this.value});
}

class ChangeSlugEvent extends TagEvent {
  final String value;
  ChangeSlugEvent({required this.value});
}

class ActionApplyEvent extends TagEvent {
  ActionApplyEvent();
}

class ChangeActionStatusEvent extends TagEvent {
  ChangeActionStatusEvent({required this.status});
  final ActionStatus status;
}

class ChangeDropDownActions extends TagEvent {
  final String value;
  ChangeDropDownActions({required this.value});
}

class SelectAllTagsEvent extends TagEvent {
  final bool isSelectAll;
  SelectAllTagsEvent({this.isSelectAll = false});
}

class SelectTagEvent extends TagEvent {
  final bool value;
  final int id;
  SelectTagEvent({
    required this.value,
    required this.id,
  });
}
