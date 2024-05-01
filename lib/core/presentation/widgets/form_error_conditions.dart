import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormErrorCondition<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  const FormErrorCondition({
    super.key,
    required this.condition,
    required this.errorText,
  });
  final bool Function(S state) condition;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<B, S>(builder: (context, state) {
      return condition(state)
          ? Text(
              errorText,
              style: textTheme.displaySmall?.copyWith(
                color: Colors.red,
              ),
            )
          : 0.vSpace();
    });
  }
}
