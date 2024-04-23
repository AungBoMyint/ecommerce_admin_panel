// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tag_bloc.dart';

class TagState extends Equatable {
  final List<AppTag> tags;
  final int paginateIndex;
  final RequiredText name;
  final String? slug;
  final List<int> selectedTags;
  final String? selectedAction;
  final ActionStatus actionStatus;
  final FormzSubmissionStatus submitStatus;
  final bool isValid;
  final bool isFirstTimePressed;
  const TagState({
    this.selectedAction,
    this.tags = const [],
    this.selectedTags = const [],
    this.actionStatus = ActionStatus.initial,
    this.isFirstTimePressed = false,
    this.slug,
    this.submitStatus = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.paginateIndex = 20,
    this.name = const RequiredText.pure(),
  });

  @override
  List<Object> get props => [
        selectedAction ?? "",
        tags,
        selectedTags,
        actionStatus,
        isFirstTimePressed,
        slug ?? "",
        submitStatus,
        isValid,
        paginateIndex,
        name,
      ];

  TagState copyWith({
    List<AppTag>? tags,
    int? paginateIndex,
    RequiredText? name,
    String? slug,
    List<int>? selectedTags,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
  }) {
    return TagState(
      tags: tags ?? this.tags,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      selectedTags: selectedTags ?? this.selectedTags,
      selectedAction: selectedAction ?? this.selectedAction,
      actionStatus: actionStatus ?? this.actionStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      isValid: isValid ?? this.isValid,
      isFirstTimePressed: isFirstTimePressed ?? this.isFirstTimePressed,
    );
  }
}
