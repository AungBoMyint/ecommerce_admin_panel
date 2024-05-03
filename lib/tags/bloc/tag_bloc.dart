import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ecommerce_admin/core/formz/fromz_class.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/tags/model/app_tag.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'tag_event.dart';
part 'tag_state.dart';

class TagBloc extends BaseBloc<AppTag, BaseEvent, TagState> {
  TagBloc() : super(const TagState()) {
    on<ChangeNameEvent>(_onChangeName);
    on<ChangeSlugEvent>(_onChangeSlug);
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

  @override
  bool checkItemById(AppTag item, int id) {
    return item.id == id;
  }

  @override
  int getId(e) {
    return e.id;
  }

  @override
  PageType getPageType() {
    return PageType.editTag;
  }

  @override
  AppTag parseFromJson(e) {
    return AppTag.fromJson(e);
  }

  @override
  Future<String> requestData() async {
    return await rootBundle.loadString("assets/mock/tags.json");
  }
}
