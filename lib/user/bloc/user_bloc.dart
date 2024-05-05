import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/core/formz/fromz_class.dart';
import 'package:ecommerce_admin/user/model/app_user.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends BaseBloc<AppUser, BaseEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<ChangeFullNameEvent>(_onChangeFullName);
    on<ChangePhoneNumberEvent>(_onChangePhoneNumber);
    on<ChangePointEvent>(_onChangePoints);
    on<ChangeIORDEvent>(_onChangeIORDEvent);
    on<ChangeInputPointEvent>(_onChangeInputPointEvent);
    on<UpdatePointEvent>(_onUpdatePoint);
  }

  FutureOr<void> _onChangeFullName(
      ChangeFullNameEvent event, Emitter<UserState> emit) {
    final fullName = RequiredText.dirty(value: event.value);
    emit(state.copyWith(
        fullName: fullName,
        isValid: Formz.validate([
          fullName,
          state.phoneNumber,
          state.profile,
        ])));
  }

  FutureOr<void> _onChangePhoneNumber(
      ChangePhoneNumberEvent event, Emitter<UserState> emit) {
    final phoneNumber = RequiredText.dirty(value: event.value);
    emit(state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([
          phoneNumber,
          state.fullName,
          state.profile,
        ])));
  }

  FutureOr<void> _onChangePoints(
      ChangePointEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(point: event.value));
  }

  @override
  void pickedImage(
      {Uint8List? result,
      required Emitter<UserState> emit,
      required UserState state}) {
    final image = RequiredObject<Uint8List?>.dirty(value: result);

    emit(state.copyWith(
        profile: image,
        isValid: Formz.validate([
          image,
          state.fullName,
          state.phoneNumber,
        ])));
    super.pickedImage(emit: emit, state: state);
  }

  @override
  bool checkItemById(AppUser item, int id) {
    return item.id == id;
  }

  @override
  int getId(e) {
    return e.id;
  }

  @override
  PageType getPageType() {
    return PageType.editUsers;
  }

  @override
  AppUser parseFromJson(e) {
    return AppUser.fromJson(e);
  }

  @override
  Future<String> requestData() async {
    return await rootBundle.loadString("assets/mock/app_user.json");
  }

  FutureOr<void> _onChangeIORDEvent(
      ChangeIORDEvent event, Emitter<UserState> emit) {
    Map<int, dynamic> newMap = Map.from(state.pointState);
    if (newMap.containsKey(event.userId)) {
      //already define
      var stateMap = Map.from(newMap[event.userId]);
      stateMap["choose"] = event.value;
      newMap[event.userId] = stateMap;
    } else {
      //if new
      newMap.putIfAbsent(event.userId, () => {"choose": event.value});
    }
    emit(state.copyWith(pointState: newMap));
  }

  FutureOr<void> _onChangeInputPointEvent(
      ChangeInputPointEvent event, Emitter<UserState> emit) async {
    var newMap = await compute(getUpdateMap, event);
    emit(state.copyWith(pointState: newMap));
  }

  FutureOr<Map<int, dynamic>> getUpdateMap(ChangeInputPointEvent event) async {
    Map<int, dynamic> newMap = Map.from(state.pointState);
    if (newMap.containsKey(event.userId)) {
      //already define
      var stateMap = Map.from(newMap[event.userId]);
      stateMap["point"] = event.value;
      newMap[event.userId] = stateMap;
    } else {
      //if new
      newMap.putIfAbsent(event.userId, () => {"point": event.value});
    }
    return newMap;
  }

  FutureOr<void> _onUpdatePoint(
      UpdatePointEvent event, Emitter<UserState> emit) async {
    //if inputPoint is not zero or -
    if (validIORD(event.userId) && validInputPoint(event.userId)) {
      //if + we increase

      if (state.pointState[event.userId]["choose"] == "+") {
        updatePoint();
      } else {
        //else we decrease
        updatePoint();
      }
      showSnackBar(
          value: "Points updating is successful.", textColor: Colors.green);
    }
  }

  Future<void> updatePoint() async {
    //show loading
    await Future.delayed(const Duration(milliseconds: 200));
    //hide loading
  }

  bool validInputPoint(int userId) {
    bool value = false;
    try {
      if (state.pointState[userId]["point"] > 0) {
        value = true;
      } else {
        showSnackBar(value: "Enter input point than 0!");
      }
    } catch (e) {
      showSnackBar(value: "Enter input point than 0!");
      value = false;
    }
    return value;
  }

  bool validIORD(int userId) {
    bool value = false;
    try {
      if (state.pointState[userId]["choose"].isNotEmpty == true) {
        value = true;
      }
    } catch (e) {
      showSnackBar(value: "Please choose + (or) -");
      value = false;
    }
    return value;
  }
}
