import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_product_event.dart';
part 'detail_product_state.dart';

class DetailProductBloc extends Bloc<DetailProductEvent, DetailProductState> {
  DetailProductBloc() : super(const DetailProductState()) {
    on<ChangeProductType>(_onChangeProductType);
    on<ChangeProductDataTab>(_onChangeProductDataTab);
  }

  FutureOr<void> _onChangeProductType(
      ChangeProductType event, Emitter<DetailProductState> emit) {
    emit(state.copyWith(productType: event.type));
  }

  FutureOr<void> _onChangeProductDataTab(
      ChangeProductDataTab event, Emitter<DetailProductState> emit) {
    emit(state.copyWith(productDataTab: event.dataTab));
  }
}
