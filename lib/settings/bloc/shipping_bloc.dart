// ignore_for_file: implementation_imports

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:bloc/src/bloc.dart';
import 'package:ecommerce_admin/category/formz/fromz_class.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/settings/model/shipping_method.dart';
import 'package:ecommerce_admin/settings/model/shipping_zone.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';

part 'shipping_event.dart';
part 'shipping_state.dart';

class ShippingBloc extends BaseBloc<ShippingZone, BaseEvent, ShippingState> {
  ShippingBloc() : super(const ShippingState()) {
    on<ChangingZoneNameEvent>(_onChangeZoneNameEvent);
    on<SelectZoneRegionEvent>(_onSelectZoneRegionEvent);
    on<ChangeShippingMethodEvent>(_onChangeShippingMethodEvent);
    on<ChangeShippingCostEvent>(_onChangeShippingCostEvent);
    on<ChangeShippingTypeEvent>(_onChangeShippingTypeEvent);
  }

  @override
  void initializeEditItem(item) {
    item = item as ShippingZone;
    final zoneName = RequiredDropdown.dirty(value: item.zoneName);
    final zoneRegions = RequiredObjectList.dirty(value: item.zoneRegions);
    final shippingMethod =
        RequiredObject.dirty(value: item.shippingMethod.name);
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(
      isValid: Formz.validate([
        zoneName,
        zoneRegions,
        shippingMethod,
      ]),
      zoneName: zoneName,
      zoneRegionList: zoneRegions,
      shippingMethod: shippingMethod,
    ));
    super.initializeEditItem(item);
  }

  @override
  Future<void> addItemEvent() async {
    //we need to add new shipping into items
    final shippingZone = ShippingZone(
      id: 0,
      zoneName: state.zoneName.value ?? "",
      zoneRegions: state.zoneRegionList.value,
      shippingMethod: ShippingMethod(
        name: state.shippingMethod.value ?? "",
        shipping: stringToShipping(state.shippingMethod.value ?? ""),
      ),
    );
    List<ShippingZone> shippingZones = List.from(state.items);
    shippingZones.add(shippingZone);
    // ignore: invalid_use_of_visible_for_testing_member
    emit(
      state.copyWith(
        items: shippingZones,
        shippingMethod: const RequiredObject.pure(),
        zoneName: const RequiredDropdown.pure(),
        zoneRegionList: const RequiredObjectList.pure(),
      ),
    );
    return super.addItemEvent();
  }

  @override
  bool checkItemById(ShippingZone item, int id) {
    return item.id == id;
  }

  @override
  int getId(e) {
    return e.id;
  }

  @override
  PageType getPageType() {
    return PageType.editShipping;
  }

  @override
  ShippingZone parseFromJson(e) {
    return ShippingZone.fromJson(e);
  }

  @override
  Future<String> requestData() async {
    await Future.delayed(const Duration(microseconds: 500));
    return "";
  }

  FutureOr<void> _onChangeZoneNameEvent(
      ChangingZoneNameEvent event, Emitter<ShippingState> emit) async {
    final zoneName = RequiredDropdown.dirty(value: event.name);
    emit(state.copyWith(
        zoneName: zoneName,
        zoneRegionList: event.name == state.zoneName.value
            ? state.zoneRegionList
            : const RequiredObjectList.dirty(value: []),
        isValid: Formz.validate([
          zoneName,
          state.zoneRegionList,
          state.shippingMethod,
        ])));
    //TODO:we need to grab province & district
    if (event.name == "Myanmar") {
      try {
        /* final states = await compute<String, List<String>>(
            getMyanmarStates, "assets/location/myanmar/myanmarstates.json"); */
        final result = await rootBundle
            .loadString("assets/location/myanmar/myanmarstates.json");
        final decodedJson = jsonDecode(result) as List<dynamic>;
        List<String> states = decodedJson
            .map((e) => (e as Map<String, dynamic>)["name"] as String)
            .toList();
        emit(state.copyWith(zoneRegions: states));
        log("🌂----------States: ${state.zoneRegions.length}");
      } catch (e) {
        log("🍾-------error is occured: $e");
      }
    } else {
      try {
        final result = await rootBundle
            .loadString("assets/location/thailand/provinces.json");
        final decodedJson = jsonDecode(result) as List<dynamic>;
        List<String> states = decodedJson
            .map((e) => (e as Map<String, dynamic>)["provinceNameEn"] as String)
            .toList();
        /*  final states = await compute(
            getThailandStates, "assets/location/thailand/provinces.json"); */
        emit(state.copyWith(zoneRegions: states));
        log("🌂----------States: ${state.zoneRegions.length}");
      } catch (e) {
        log("🍾-------error is occured: $e");
      }
    }
  }

  FutureOr<List<String>> getMyanmarStates(String assetLocation) async {
    final result = await rootBundle.loadString(assetLocation);
    final decodedJson = jsonDecode(result) as List<dynamic>;
    List<String> states = decodedJson
        .map((e) => (e as Map<String, dynamic>)["name"] as String)
        .toList();
    return states;
  }

  FutureOr<List<String>> getThailandStates(String assetLocation) async {
    final result = await rootBundle.loadString(assetLocation);
    final decodedJson = jsonDecode(result) as List<dynamic>;
    List<String> states = decodedJson
        .map((e) => (e as Map<String, dynamic>)["provinceNameEn"] as String)
        .toList();
    return states;
  }

  FutureOr<void> _onSelectZoneRegionEvent(
      SelectZoneRegionEvent event, Emitter<ShippingState> emit) {
    //if already contains,we remove it
    if (state.zoneRegionList.value.contains(event.zoneRegion)) {
      List<String> newList = List.from(state.zoneRegionList.value);
      newList.remove(event.zoneRegion);
      final zoneRegionList = RequiredObjectList.dirty(value: newList);
      emit(state.copyWith(
          zoneRegionList: zoneRegionList,
          isValid: Formz.validate([
            zoneRegionList,
            state.zoneName,
            state.shippingMethod,
          ])));
    } else {
      //if not contains, we add it
      List<String> newList = List.from(state.zoneRegionList.value);
      newList.add(event.zoneRegion);
      final zoneRegionList = RequiredObjectList.dirty(value: newList);
      emit(state.copyWith(
          zoneRegionList: zoneRegionList,
          isValid: Formz.validate([
            zoneRegionList,
            state.zoneName,
            state.shippingMethod,
          ])));
    }
  }

  FutureOr<void> _onChangeShippingMethodEvent(
      ChangeShippingMethodEvent event, Emitter<ShippingState> emit) {
    final shippingMethod =
        RequiredObject<String>.dirty(value: event.shippingMethod);
    emit(state.copyWith(
        shippingMethod: shippingMethod,
        isValid: Formz.validate([
          state.zoneRegionList,
          state.zoneName,
          shippingMethod,
        ])));
  }

  FutureOr<void> _onChangeShippingCostEvent(
      ChangeShippingCostEvent event, Emitter<ShippingState> emit) {
    emit(state.copyWith(cost: event.cost));
  }

  FutureOr<void> _onChangeShippingTypeEvent(
      ChangeShippingTypeEvent event, Emitter<ShippingState> emit) {
    emit(
        state.copyWith(shippingType: stringToFreeShipping(event.shippingType)));
  }
}
