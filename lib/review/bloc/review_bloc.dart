import 'dart:async';

import 'package:bloc/src/bloc.dart';
import 'package:ecommerce_admin/category/formz/fromz_class.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/review/model/app_review.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends BaseBloc<AppReview, BaseEvent, ReviewState> {
  ReviewBloc() : super(const ReviewState()) {
    on<ChangeAuthorEvent>(_onChangeAuthorEvent);
    on<ChangeProductEvent>(_onChangeProductEvent);
    on<ChangeReviewEvent>(_onChangeReviewEvent);
    on<ChangeRatingEvent>(_onChangeRatingEvent);
  }

  @override
  bool checkItemById(item, int id) {
    return item.id == id;
  }

  @override
  int getId(e) {
    return e.id;
  }

  @override
  PageType getPageType() {
    return PageType.editReview;
  }

  @override
  parseFromJson(e) {
    return AppReview.fromJson(e);
  }

  @override
  Future<String> requestData() async {
    return await rootBundle.loadString("assets/mock/review.json");
  }

  _onChangeAuthorEvent(ChangeAuthorEvent event, Emitter<ReviewState> emit) {
    final author = RequiredDropdown.dirty(value: event.value);
    emit(state.copyWith(
        author: author,
        isValid: Formz.validate([
          author,
          state.product,
          state.review,
          state.rating,
        ])));
  }

  FutureOr<void> _onChangeProductEvent(
      ChangeProductEvent event, Emitter<ReviewState> emit) {
    final product = RequiredDropdown.dirty(value: event.value);
    emit(state.copyWith(
        product: product,
        isValid: Formz.validate([
          state.author,
          product,
          state.review,
          state.rating,
        ])));
  }

  FutureOr<void> _onChangeReviewEvent(
      ChangeReviewEvent event, Emitter<ReviewState> emit) {
    final review = RequiredText.dirty(value: event.value);
    emit(state.copyWith(
        review: review,
        isValid: Formz.validate([
          review,
          state.product,
          state.author,
          state.rating,
        ])));
  }

  FutureOr<void> _onChangeRatingEvent(
      ChangeRatingEvent event, Emitter<ReviewState> emit) {
    final rating =
        RequiredDouble.dirty(value: double.tryParse(event.value) ?? 0.0);
    emit(state.copyWith(
        rating: rating,
        isValid: Formz.validate([
          rating,
          state.product,
          state.review,
          state.author,
        ])));
  }
}
