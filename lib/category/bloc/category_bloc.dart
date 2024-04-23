import 'dart:async';
import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin/category/formz/fromz_class.dart';
import 'package:ecommerce_admin/category/model/app_category.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/constant.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(const CategoryState()) {
    on<FetchCategoryEvent>(_onFetchCategory);
    on<FetchMoreCategoryEvent>(_onFetchMoreCategory);
    on<AddCategoryEvent>(_onAddCategoryEvent);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoriesEvent>(_onDeleteCategory);
    on<ChangeNameEvent>(_onChangeName);
    on<ChangeDropDownActions>(_onChangeDropDownActions);
    on<ChangeDropDownParentCategory>(_onChangeDropDownParentCategory);
    on<ChangeDropDownDisplayType>(_onChangeDropDownDisplayType);
    on<ActionApplyEvent>(_onActionApply);
    on<ChangeActionStatusEvent>(_onChangeActionStatus);
    on<SelectAllCategoriesEvent>(_onSelectAllCategories);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<PickImageEvent>(_onPickImage);
    on<SearchCategoryEvent>(_onSearchCategory);
  }

  FutureOr<void> _onFetchCategory(
      FetchCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state.actionStatus == ActionStatus.fetching) {
      return;
    }
    emit(state.copyWith(actionStatus: ActionStatus.fetching));
    //fetching products data
    final categoriesJson =
        await rootBundle.loadString("assets/mock/categories.json");
    final List<dynamic> results = jsonDecode(categoriesJson);
    var categories = results.map((e) => AppCategory.fromJson(e)).toList();
    categories.removeRange(state.paginateIndex, 1000);
    emit(state.copyWith(
        actionStatus: ActionStatus.initial, categories: categories));
  }

  FutureOr<void> _onFetchMoreCategory(
      FetchMoreCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state.actionStatus == ActionStatus.fetchingMore) {
      return;
    }
    emit(state.copyWith(actionStatus: ActionStatus.fetchingMore));
    //fetching products data
    final productsJson =
        await rootBundle.loadString("assets/mock/categories.json");
    final List<dynamic> results = jsonDecode(productsJson);
    var categories = results.map((e) => AppCategory.fromJson(e)).toList();
    categories.removeRange(state.paginateIndex * 2, 1000);
    emit(state.copyWith(
        actionStatus: ActionStatus.initial,
        categories: categories,
        paginateIndex: state.paginateIndex * 2));
  }

  FutureOr<void> _onAddCategoryEvent(
      AddCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isFirstTimePressed: true));
    try {
      if (state.isValid) {
        emit(state.copyWith(
            submitStatus: FormzSubmissionStatus.inProgress,
            actionStatus: ActionStatus.adding));
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(
            isValid: false,
            isFirstTimePressed: false,
            submitStatus: FormzSubmissionStatus.success,
            actionStatus: ActionStatus.addingSuccess));
      }
    } catch (e) {
      emit(state.copyWith(
        submitStatus: FormzSubmissionStatus.failure,
        actionStatus: ActionStatus.addingFail,
      ));
    }
  }

  FutureOr<void> _onUpdateCategory(
      UpdateCategoryEvent event, Emitter<CategoryState> emit) async {
    try {
      if (state.isValid) {
        emit(state.copyWith(
            submitStatus: FormzSubmissionStatus.inProgress,
            actionStatus: ActionStatus.editing));
        await Future.delayed(const Duration(milliseconds: 500));
        emit(state.copyWith(
            isValid: false,
            submitStatus: FormzSubmissionStatus.success,
            actionStatus: ActionStatus.editingSuccess));
      }
    } catch (e) {
      emit(state.copyWith(
          submitStatus: FormzSubmissionStatus.failure,
          actionStatus: ActionStatus.editingFail));
    }
  }

  FutureOr<void> _onDeleteCategory(
      DeleteCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(actionStatus: ActionStatus.deleting));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(actionStatus: ActionStatus.deletingSuccess));
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

  FutureOr<void> _onChangeDropDownActions(
      ChangeDropDownActions event, Emitter<CategoryState> emit) {
    emit(state.copyWith(selectedAction: event.value));
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

  FutureOr<void> _onActionApply(
      ActionApplyEvent event, Emitter<CategoryState> emit) async {
    if (state.selectedAction == "Delete" &&
        state.selectedCategories.isNotEmpty) {
      //can delete
      emit(state.copyWith(actionStatus: ActionStatus.deleting));
      await Future.delayed(const Duration(milliseconds: 500));
      List<AppCategory> list = List.from(state.categories);
      for (var element in state.selectedCategories) {
        list.removeWhere((item) => item.id == element);
      }
      emit(state.copyWith(categories: list));
    }
    if (state.selectedAction == "Edit" && state.selectedCategories.isNotEmpty) {
      if (state.selectedCategories.length > 1) {
        showCannotEditMultipleItem();
      } else {
        navigatorKey.currentContext?.read<CoreBloc>().add(
              ChangePageEvent(page: PageType.editCategory),
            );

        add(
          ChangeActionStatusEvent(status: ActionStatus.initial),
        );
      }
    }
  }

  FutureOr<void> _onChangeActionStatus(
      ChangeActionStatusEvent event, Emitter<CategoryState> emit) {
    emit(state.copyWith(actionStatus: event.status));
  }

  FutureOr<void> _onSearchCategory(
      SearchCategoryEvent event, Emitter<CategoryState> emit) async {
    if (state.actionStatus == ActionStatus.searching) return;
    emit(state.copyWith(actionStatus: ActionStatus.searching));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(actionStatus: ActionStatus.initial));
  }

  FutureOr<void> _onSelectAllCategories(
      SelectAllCategoriesEvent event, Emitter<CategoryState> emit) {
    if (event.isSelectAll) {
      emit(
        state.copyWith(
          selectedCategories: state.categories.map((e) => e.id).toList(),
        ),
      );
    } else {
      emit(state.copyWith(selectedCategories: []));
    }
  }

  FutureOr<void> _onSelectCategory(
      SelectCategoryEvent event, Emitter<CategoryState> emit) {
    List<int> list = List.from(state.selectedCategories);
    if (event.value) {
      //select
      list.add(event.id);
    } else {
      list.remove(event.id);
    }
    emit(state.copyWith(selectedCategories: list));
  }
}
