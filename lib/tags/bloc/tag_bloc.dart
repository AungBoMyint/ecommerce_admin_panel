import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin/category/formz/fromz_class.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/main.dart';
import 'package:ecommerce_admin/tags/model/app_tag.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends Bloc<TagEvent, TagState> {
  TagBloc() : super(const TagState()) {
    on<FetchTagEvent>(_onFetchTag);
    on<FetchMoreTagEvent>(_onFetchMoreTag);
    on<AddTagEvent>(_onAddTagEvent);
    on<UpdateTagEvent>(_onUpdateTag);
    on<DeleteTagsEvent>(_onDeleteTag);
    on<ChangeNameEvent>(_onChangeName);
    on<ChangeSlugEvent>(_onChangeSlug);
    on<ChangeDropDownActions>(_onChangeDropDownActions);
    on<ActionApplyEvent>(_onActionApply);
    on<ChangeActionStatusEvent>(_onChangeActionStatus);
    on<SelectAllTagsEvent>(_onSelectAllTags);
    on<SelectTagEvent>(_onSelectTag);
    on<SearchTagEvent>(_onSearchTag);
  }

  FutureOr<void> _onFetchTag(
      FetchTagEvent event, Emitter<TagState> emit) async {
    if (state.actionStatus == ActionStatus.fetching) {
      return;
    }
    emit(state.copyWith(actionStatus: ActionStatus.fetching));
    //fetching products data
    final tagsJson = await rootBundle.loadString("assets/mock/tags.json");
    final List<dynamic> results = jsonDecode(tagsJson);
    var tags = results.map((e) => AppTag.fromJson(e)).toList();
    tags.removeRange(state.paginateIndex, 1000);
    emit(state.copyWith(actionStatus: ActionStatus.initial, tags: tags));
  }

  FutureOr<void> _onFetchMoreTag(
      FetchMoreTagEvent event, Emitter<TagState> emit) async {
    if (state.actionStatus == ActionStatus.fetchingMore) {
      return;
    }
    emit(state.copyWith(actionStatus: ActionStatus.fetchingMore));
    //fetching products data
    final tagsJson = await rootBundle.loadString("assets/mock/tags.json");
    final List<dynamic> results = jsonDecode(tagsJson);
    var tags = results.map((e) => AppTag.fromJson(e)).toList();
    tags.removeRange(state.paginateIndex * 2, 1000);
    emit(state.copyWith(
        actionStatus: ActionStatus.initial,
        tags: tags,
        paginateIndex: state.paginateIndex * 2));
  }

  FutureOr<void> _onAddTagEvent(
      AddTagEvent event, Emitter<TagState> emit) async {
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

  FutureOr<void> _onUpdateTag(
      UpdateTagEvent event, Emitter<TagState> emit) async {
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

  FutureOr<void> _onDeleteTag(
      DeleteTagsEvent event, Emitter<TagState> emit) async {
    emit(state.copyWith(actionStatus: ActionStatus.deleting));
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.copyWith(actionStatus: ActionStatus.deletingSuccess));
  }

  FutureOr<void> _onChangeName(ChangeNameEvent event, Emitter<TagState> emit) {
    final name = RequiredText.dirty(value: event.value);
    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([
        name,
      ]),
    ));
  }

  FutureOr<void> _onChangeSlug(ChangeSlugEvent event, Emitter<TagState> emit) {
    emit(state.copyWith(slug: event.value));
  }

  FutureOr<void> _onChangeDropDownActions(
      ChangeDropDownActions event, Emitter<TagState> emit) {
    emit(state.copyWith(selectedAction: event.value));
  }

  FutureOr<void> _onActionApply(
      ActionApplyEvent event, Emitter<TagState> emit) async {
    if (state.selectedAction == "Delete" && state.selectedTags.isNotEmpty) {
      //can delete
      emit(state.copyWith(actionStatus: ActionStatus.deleting));
      await Future.delayed(const Duration(milliseconds: 500));
      List<AppTag> list = List.from(state.tags);
      for (var element in state.selectedTags) {
        list.removeWhere((item) => item.id == element);
      }
      emit(state.copyWith(tags: list));
    }
    if (state.selectedAction == "Edit" && state.selectedTags.isNotEmpty) {
      if (state.selectedTags.length > 1) {
        showCannotEditMultipleItem();
      } else {
        navigatorKey.currentContext
            ?.read<CoreBloc>()
            .add(ChangePageEvent(page: PageType.editTag));

        add(
          ChangeActionStatusEvent(status: ActionStatus.initial),
        );
      }
    }
  }

  FutureOr<void> _onChangeActionStatus(
      ChangeActionStatusEvent event, Emitter<TagState> emit) {
    emit(state.copyWith(actionStatus: event.status));
  }

  FutureOr<void> _onSelectAllTags(
      SelectAllTagsEvent event, Emitter<TagState> emit) {
    if (event.isSelectAll) {
      emit(
        state.copyWith(
          selectedTags: state.tags.map((e) => e.id).toList(),
        ),
      );
    } else {
      emit(state.copyWith(selectedTags: []));
    }
  }

  FutureOr<void> _onSelectTag(SelectTagEvent event, Emitter<TagState> emit) {
    List<int> list = List.from(state.selectedTags);
    if (event.value) {
      //select
      list.add(event.id);
    } else {
      list.remove(event.id);
    }
    emit(state.copyWith(selectedTags: list));
  }

  FutureOr<void> _onSearchTag(
      SearchTagEvent event, Emitter<TagState> emit) async {
    if (state.actionStatus == ActionStatus.searching) return;
    emit(state.copyWith(actionStatus: ActionStatus.searching));
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(actionStatus: ActionStatus.initial));
  }
}
