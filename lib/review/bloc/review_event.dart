part of 'review_bloc.dart';

class ReviewEvent extends BaseEvent {}

class ChangeReviewEvent extends ReviewEvent {
  final String value;
  ChangeReviewEvent({required this.value});
}

class ChangeRatingEvent extends ReviewEvent {
  final String value;
  ChangeRatingEvent({required this.value});
}

class ChangeAuthorEvent extends ReviewEvent {
  final String value;
  ChangeAuthorEvent({required this.value});
}

class ChangeProductEvent extends ReviewEvent {
  final String value;
  ChangeProductEvent({required this.value});
}
