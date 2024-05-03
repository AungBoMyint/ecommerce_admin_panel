part of 'tag_bloc.dart';

class TagEvent extends BaseEvent {}

class ChangeNameEvent extends TagEvent {
  final String value;
  ChangeNameEvent({required this.value});
}

class ChangeSlugEvent extends TagEvent {
  final String value;
  ChangeSlugEvent({required this.value});
}
