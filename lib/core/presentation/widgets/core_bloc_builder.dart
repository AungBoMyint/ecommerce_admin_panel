import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoreBlocBuilder extends StatelessWidget {
  final Widget Function(CoreState state) builder;
  const CoreBlocBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoreBloc, CoreState>(builder: (context, state) {
      return builder(state);
    });
  }
}
