part of 'base_bloc.dart';

abstract class BaseState<T, S> extends Equatable {
  final List<T> items;
  final T? editItem;
  final int paginateIndex;
  //-----form variables-----//
  //------endform----------//
  final List<int> selectedItems;
  final String? selectedAction;
  final ActionStatus actionStatus;
  final FormzSubmissionStatus submitStatus;
  final bool isValid;
  final bool isFirstTimePressed;
  const BaseState({
    this.editItem,
    this.items = const [],
    this.paginateIndex = 20,
    this.selectedAction,
    this.selectedItems = const [],
    this.submitStatus = FormzSubmissionStatus.initial,
    this.actionStatus = ActionStatus.initial,
    this.isFirstTimePressed = false,
    this.isValid = false,
  });

  @override
  List<Object> get props => [
        items,
        editItem ?? "",
        paginateIndex,
        selectedAction ?? '',
        selectedItems,
        submitStatus,
        actionStatus,
        isFirstTimePressed,
        isValid,
      ];

  S copyWith({
    List<T>? items,
    T? editItem,
    int? paginateIndex,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
  });
}
