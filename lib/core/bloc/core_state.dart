part of 'core_bloc.dart';

class CoreState extends Equatable {
  final PageType page;
  const CoreState({this.page = PageType.allProducts});

  @override
  List<Object?> get props => [page];

  CoreState copyWith({
    PageType? page,
  }) {
    return CoreState(
      page: page ?? this.page,
    );
  }
}
