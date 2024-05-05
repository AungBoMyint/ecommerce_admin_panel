part of 'user_bloc.dart';

class UserState extends BaseState<AppUser, UserState> {
  final RequiredText fullName;
  final RequiredText phoneNumber;
  final int point;
  final RequiredObject<Uint8List?> profile;
  final Map<int, dynamic> pointState;
  const UserState({
    this.pointState = const {},
    this.fullName = const RequiredText.pure(),
    this.phoneNumber = const RequiredText.pure(),
    this.point = 0,
    this.profile = const RequiredObject<Uint8List?>.pure(),
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
        pointState,
        fullName,
        phoneNumber,
        point,
        profile,
        ...super.props,
      ];

  @override
  UserState copyWith({
    List<AppUser>? items,
    AppUser? editItem,
    int? paginateIndex,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
    RequiredText? fullName,
    RequiredText? phoneNumber,
    int? point,
    RequiredObject<Uint8List?>? profile,
    Map<int, dynamic>? pointState,
  }) {
    return UserState(
      pointState: pointState ?? this.pointState,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      point: point ?? this.point,
      profile: profile ?? this.profile,
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
