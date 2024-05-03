import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin/core/formz/fromz_class.dart';
import 'package:ecommerce_admin/category/model/app_category.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends BaseBloc<AppCategory, BaseEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState()) {
    on<ChangeNameEvent>(_onChangeName);
    on<ChangeDropDownParentCategory>(_onChangeDropDownParentCategory);
    on<ChangeDropDownDisplayType>(_onChangeDropDownDisplayType);
    on<PickImageEvent>(_onPickImage);
  }

  FutureOr<void> _onChangeName(
      ChangeNameEvent event, Emitter<CategoryState> emit) {
    final name = RequiredText.dirty(value: event.value);
    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([
        name,
        state.image,
      ]),
    ));
  }

  FutureOr<void> _onChangeDropDownParentCategory(
      ChangeDropDownParentCategory event, Emitter<CategoryState> emit) {
    emit(state.copyWith(
      selectedParentCategory: event.value,
    ));
  }

  FutureOr<void> _onChangeDropDownDisplayType(
      ChangeDropDownDisplayType event, Emitter<CategoryState> emit) {
    emit(state.copyWith(displayType: event.value));
  }

  FutureOr<void> _onPickImage(
      PickImageEvent event, Emitter<CategoryState> emit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (!(result == null)) {
      final image = RequiredImage.dirty(value: result.files.single.path);
      emit(state.copyWith(
        image: image,
        isValid: Formz.validate([
          state.name,
          image,
        ]),
      ));
    } else {
      // User canceled the picker
    }
  }

  @override
  bool checkItemById(AppCategory item, int id) {
    return item.id == id;
  }

  @override
  int getId(e) {
    return e.id;
  }

  @override
  PageType getPageType() {
    return PageType.editCategory;
  }

  @override
  AppCategory parseFromJson(e) {
    return AppCategory.fromJson(e);
  }

  @override
  Future<String> requestData() async {
    return await rootBundle.loadString("assets/mock/categories.json");
  }
}
