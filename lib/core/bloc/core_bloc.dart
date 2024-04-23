import 'dart:async';

import 'package:ecommerce_admin/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'core_event.dart';
part 'core_state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  CoreBloc() : super(const CoreState()) {
    on<ChangePageEvent>(_onChangePage);
  }

  FutureOr<void> _onChangePage(ChangePageEvent event, Emitter<CoreState> emit) {
    emit(state.copyWith(page: event.page));
  }
}
