import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../data/actions_status.dart';

part 'base_event.dart';
part 'base_state.dart';

abstract class BaseBloc<T, E extends BaseEvent, S extends BaseState>
    extends Bloc<E, S> {
  BaseBloc(super.s) {
    on<E>((event, emit) async {
      if (event is FetchEvent) {
        await _onFetchEvent(event, emit);
        return;
      } else if (event is FetchMoreEvent) {
        await _onFetchMoreEvent(event, emit);
        return;
      } else if (event is FilterEvent) {
        await _onFilterEvent(event, emit);
        return;
      } else if (event is SearchEvent) {
        await _onSearchEvent(event, emit);
        return;
      } else if (event is DeleteEvent) {
        await _onDeleteEvent(event, emit);
        return;
      } else if (event is AddEvent) {
        await _onAddEvent(event, emit);
        return;
      } else if (event is UpdateEvent) {
        await _onUpdateEvent(event, emit);
        return;
      } else if (event is ChangeActionsEvent) {
        await _onChangeActionsEvent(event, emit);
        return;
      } else if (event is ActionApplyEvent) {
        await _onActionApplyEvent(event, emit);
        return;
      } else if (event is ChangeActionsStatusEvent) {
        await _onChangeActionsStatusEvent(event, emit);
        return;
      } else if (event is SelectItemEvent) {
        await _onSelectItemEvent(event, emit);
        return;
      } else if (event is SelectAllItemsEvent) {
        await _onSelectAllItemsEvent(event, emit);
      } else if (event is SetEditItemEvent) {
        await _onSetEditItemEvent(event, emit);
      } else if (event is PickImageEvent) {
        await _onPickImageEvent(event, emit);
      } else {
        log("-🍾---Event is not found, something is wrong in BaseBloc code.\n"
            "(or) may be event from children.");
      }
    }, transformer: droppable());
  }

  FutureOr<void> _onFetchEvent(
      FetchEvent event, Emitter<BaseState> emit) async {
    if (state.actionStatus == ActionStatus.fetching) {
      return;
    }
    emit(state.copyWith(actionStatus: ActionStatus.fetching));
    //fetching products data
    final responseJson = await requestData();
    final List<dynamic> results = jsonDecode(responseJson);
    List<T> result = results.map((e) => parseFromJson(e)).toList();
    result.removeRange(state.paginateIndex, 1000);
    emit(
      state.copyWith(
        actionStatus: ActionStatus.initial,
        items: result,
      ),
    );
  }

  FutureOr<void> _onFetchMoreEvent(
      FetchMoreEvent event, Emitter<BaseState> emit) async {
    if (state.actionStatus == ActionStatus.fetchingMore) {
      return;
    }
    emit(state.copyWith(actionStatus: ActionStatus.fetchingMore));
    //fetching products data
    final json = await requestData();
    final List<dynamic> results = jsonDecode(json);
    List<T> items = results.map((e) => parseFromJson(e)).toList();
    items.removeRange(state.paginateIndex * 2, 1000);
    emit(state.copyWith(
        actionStatus: ActionStatus.initial,
        items: items,
        paginateIndex: state.paginateIndex * 2));
  }

  Future<String> requestData();

  T parseFromJson(e);

  FutureOr<void> _onSearchEvent(
      SearchEvent event, Emitter<BaseState> emit) async {
    if (state.actionStatus == ActionStatus.searching) return;
    emit(state.copyWith(actionStatus: ActionStatus.searching));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(actionStatus: ActionStatus.initial));
  }

  FutureOr<void> _onDeleteEvent(
      DeleteEvent event, Emitter<BaseState> emit) async {
    emit(state.copyWith(actionStatus: ActionStatus.deleting));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(actionStatus: ActionStatus.deletingSuccess));
  }

  FutureOr<void> _onAddEvent(AddEvent event, Emitter<BaseState> emit) async {
    emit(state.copyWith(isFirstTimePressed: true));
    try {
      if (state.isValid) {
        emit(state.copyWith(
            submitStatus: FormzSubmissionStatus.inProgress,
            actionStatus: ActionStatus.adding));
        await addItemEvent();
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

  FutureOr<void> _onUpdateEvent(
      UpdateEvent event, Emitter<BaseState> emit) async {
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

  FutureOr<void> _onChangeActionsEvent(
      ChangeActionsEvent event, Emitter<BaseState> emit) {
    emit(state.copyWith(selectedAction: event.value));
  }

  FutureOr<void> _onActionApplyEvent(
      ActionApplyEvent event, Emitter<BaseState> emit) async {
    if (state.selectedAction == "Delete" && state.selectedItems.isNotEmpty) {
      //can delete
      emit(state.copyWith(actionStatus: ActionStatus.deleting));
      await Future.delayed(const Duration(milliseconds: 500));
      List<T> list = List.from(state.items);
      for (var id in state.selectedItems) {
        list.removeWhere((item) => checkItemById(item, id));
      }
      emit(state.copyWith(items: list));
    }
    if (state.selectedAction == "Edit" && state.selectedItems.isNotEmpty) {
      if (state.selectedItems.length > 1) {
        showCannotEditMultipleItem();
      } else {
        navigatorKey.currentContext?.read<CoreBloc>().add(
              ChangePageEvent(page: getPageType()),
            );
        emit(state.copyWith(actionStatus: ActionStatus.initial));
      }
    }
  }

  PageType getPageType();

  FutureOr<void> _onChangeActionsStatusEvent(
      ChangeActionsStatusEvent event, Emitter<BaseState> emit) {
    emit(state.copyWith(actionStatus: event.status));
  }

  bool checkItemById(T item, int id);

  FutureOr<void> _onSelectItemEvent(
      SelectItemEvent event, Emitter<BaseState> emit) {
    List<int> list = List.from(state.selectedItems);
    if (event.value) {
      //select
      list.add(event.id);
    } else {
      list.remove(event.id);
    }
    emit(state.copyWith(selectedItems: list));
  }

  FutureOr<void> _onSelectAllItemsEvent(
      SelectAllItemsEvent event, Emitter<BaseState> emit) {
    if (event.isSelectAll) {
      emit(
        state.copyWith(
          selectedItems: state.items.map((e) => getId(e)).toList(),
        ),
      );
    } else {
      emit(state.copyWith(selectedItems: []));
    }
  }

  int getId(e);

  FutureOr<void> _onFilterEvent(
      FilterEvent event, Emitter<BaseState> emit) async {
    log("---🎯 Filtering..........");
    if (state.actionStatus == ActionStatus.fetching) return;
    emit(state.copyWith(actionStatus: ActionStatus.searching));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(actionStatus: ActionStatus.initial));
  }

  Future<void> addItemEvent() async {}

  FutureOr<void> _onSetEditItemEvent(SetEditItemEvent event, Emitter<S> emit) {
    emit(state.copyWith(editItem: event.item));
    initializeEditItem(event.item);
  }

  void initializeEditItem(item) {}

  FutureOr<void> _onPickImageEvent(E event, Emitter<S> emit) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (!(result == null)) {
      log("-Return Image: ${result.files.single.bytes}");
      pickedImage(result: result.files.single.bytes, emit: emit, state: state);
    } else {
      // User canceled the picker
    }
  }

  void pickedImage(
      {Uint8List? result, required Emitter<S> emit, required S state}) {}
}
