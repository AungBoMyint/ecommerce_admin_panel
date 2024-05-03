import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/data/actions_status.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/table/base_table_widget.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../widgets/loading_widget.dart';

abstract class BaseTableFormWidgetState<T extends StatefulWidget,
    B extends StateStreamable<S>, S extends BaseState> extends State<T> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.endOfFrame.then((value) => endOfFrame());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        (context.read<B>() as BaseBloc).add(FetchMoreEvent());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    childDispose();
    super.dispose();
  }

  void endOfFrame();
  void childDispose() {}
  bool hasForm() {
    return true;
  }

  ThemeData getTheme() {
    return Theme.of(context);
  }

  TextTheme getTextTheme() => Theme.of(context).textTheme;

  Size getSize() {
    return MediaQuery.of(context).size;
  }

  Widget topActions();
  Widget getTitle();
  Widget getForm();
  Widget getSubmitButton();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          topActions(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasForm()) ...[
                  20.hSpace(),
                ],
                if (hasForm()) ...[
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getTitle(),
                          20.vSpace(),
                          //Category Form
                          getForm(),
                          20.vSpace(),
                          //sumbit button
                          getSubmitButton(),
                        ],
                      ),
                    ),
                  )
                ],
                BlocBuilder<B, S>(
                  builder: (context, state) {
                    switch (state.actionStatus) {
                      case ActionStatus.fetching:
                        return const Expanded(child: LoadingWidget());
                      case ActionStatus.searching:
                        return const Expanded(child: LoadingWidget());
                      default:
                        return BaseTable(
                          scrollController: _scrollController,
                          flex: 2,
                          actionsWidget: hasForm()
                              ? Row(
                                  children: [
                                    20.hSpace(),
                                    DropDownWidget(
                                      hintText: "Actions",
                                      items: const ["Edit", "Delete"],
                                      width: 100,
                                      value: state.selectedAction,
                                      onChanged: (v) =>
                                          (context.read<B>() as BaseBloc).add(
                                              ChangeActionsEvent(
                                                  value: v ?? "")),
                                    ),
                                    10.hSpace(),
                                    LinkTextButton(
                                      height: 35,
                                      onPressed: () {
                                        (context.read<B>() as BaseBloc)
                                            .add(ActionApplyEvent());
                                      },
                                      text: "Apply",
                                      fillColor: linkBTNColor,
                                    ),
                                  ],
                                )
                              : const Gap(0),
                          columnList: columnList(),
                          rowList: rowList(state),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*  LayoutSize getLayoutSize() {
    final size = getSize();
    final width = size.width;
    if(width < )
  } */

  List<Widget> columnList();

  List<List<DataCell>> rowList(S state);
}

enum LayoutSize {
  greatherThanDesktop,
  greatherThanTablet,
  greatherThanMobile,
}
