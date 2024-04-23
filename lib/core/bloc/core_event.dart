part of 'core_bloc.dart';

abstract class CoreEvent {}

class ChangePageEvent extends CoreEvent {
  final PageType page;
  ChangePageEvent({required this.page});
}
