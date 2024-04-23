import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    /* if (bloc is ProductBloc) {
      final state = transition.nextState as ProductState;
      log("SelectedAction: ${state.selectedAction}\nSelectedProducts: ${state.selectedProducts.length} \nEvent is: ${transition.event is ActionApplyEvent}");
      if ((state.actionStatus == ActionStatus.canEdit) &&
          (state.selectedAction == "Edit") &&
          (state.selectedProducts.length == 1)) {
        log("Correct Condition");
        //change route
        navigatorKey.currentContext?.read<CoreBloc>().add(
              ChangePageEvent(page: PageType.editProduct),
            );
        navigatorKey.currentContext?.read<ProductBloc>().add(
              ChangeActionStatusEvent(status: ActionStatus.initial),
            );
      }
    } */
    super.onTransition(bloc, transition);
  }
}
