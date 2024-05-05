part of 'user_bloc.dart';

class UserEvent extends BaseEvent {}

class ChangeFullNameEvent extends UserEvent {
  final String value;
  ChangeFullNameEvent({required this.value});
}

class ChangePhoneNumberEvent extends UserEvent {
  final String value;
  ChangePhoneNumberEvent({required this.value});
}

class ChangePointEvent extends UserEvent {
  final int value;
  ChangePointEvent({required this.value});
}

class ChangeIORDEvent extends UserEvent {
  final String value;
  final int userId;
  ChangeIORDEvent({
    required this.value,
    required this.userId,
  });
}

class ChangeInputPointEvent extends UserEvent {
  final int value;
  final int userId;
  ChangeInputPointEvent({
    required this.value,
    required this.userId,
  });
}

class UpdatePointEvent extends UserEvent {
  final int userId;
  UpdatePointEvent({required this.userId});
}
