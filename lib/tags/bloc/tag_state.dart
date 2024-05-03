// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tag_bloc.dart';

class TagState extends BaseState<AppTag, TagState> {
  final RequiredText name;
  final String? slug;
  const TagState({
    this.slug,
    this.name = const RequiredText.pure(),
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
        slug ?? "",
        name,
        ...super.props,
      ];

  @override
  TagState copyWith({
    List<AppTag>? items,
    AppTag? editItem,
    int? paginateIndex,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
    RequiredText? name,
    String? slug,
  }) {
    return TagState(
      name: name ?? this.name,
      slug: slug ?? this.slug,
      editItem: editItem ?? this.editItem,
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
