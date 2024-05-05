import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/pages/base_table_form_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/drop_down_widget.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/main_title_text.dart';
import 'package:ecommerce_admin/core/presentation/widgets/top_actions.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/user/bloc/user_bloc.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTable extends StatefulWidget {
  const UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState
    extends BaseTableFormWidgetState<UserTable, UserBloc, UserState> {
  @override
  List<Widget> columnList() {
    final textTheme = getTheme().textTheme;
    final isSTABLET = getSize().width < STABLET;
    final ismTABLET = getSize().width < mTABLET;
    return [
      BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.length == state.items.length,
            onChanged: (v) => context.read<UserBloc>().add(
                  SelectAllItemsEvent(
                    isSelectAll: v ?? false,
                  ),
                ),
          );
        },
      ),
      if (!isSTABLET)
        Text(
          "Profile",
          style: textTheme.displaySmall,
        ),
      if (!isSTABLET)
        Text(
          "Phone No",
          style: textTheme.displaySmall,
        ),
      Text(
        "Name",
        style: textTheme.displaySmall,
      ),
      if (!ismTABLET)
        Text(
          "Points",
          style: textTheme.displaySmall,
        ),
      Text(
        "Choose +/-",
        style: textTheme.displaySmall,
      ),
      Text(
        "Enter points",
        style: textTheme.displaySmall,
      ),
      Text(
        "Action",
        style: textTheme.displaySmall,
      ),
    ];
  }

  @override
  bool hasForm() {
    return false;
  }

  @override
  void endOfFrame() {
    context.read<UserBloc>().add(FetchEvent());
  }

  @override
  Widget getForm() {
    return Container();
  }

  @override
  Widget getSubmitButton() {
    return Container();
  }

  @override
  Widget getTitle() {
    return Container();
  }

  @override
  List<List<DataCell>> rowList(UserState state) {
    final textTheme = getTheme().textTheme;
    final isSTABLET = getSize().width < STABLET;
    final ismTABLET = getSize().width < mTABLET;
    return List.generate(state.items.length, (index) {
      final user = state.items[index];
      return [
        DataCell(
          Checkbox(
            side: const BorderSide(width: 2, color: linkBTNColor),
            value: state.selectedItems.contains(
              user.id,
            ),
            onChanged: (v) => context.read<UserBloc>().add(
                  SelectItemEvent(
                    value: v ?? false,
                    id: user.id,
                  ),
                ),
          ),
        ),
        //profile,
        if (!isSTABLET)
          DataCell(CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              user.image,
            ),
          )),
        //phone number
        if (!isSTABLET)
          DataCell(
            Text(
              user.phoneNo,
              style: textTheme.headlineMedium,
            ),
          ),
        //name
        DataCell(
          MainTitleText(
            e: user.fullName,
            onEdit: () => context.read<CoreBloc>().add(
                  ChangePageEvent(
                    page: PageType.editUsers,
                  ),
                ),
          ),
        ),
        //total point
        if (!ismTABLET)
          DataCell(
            Text(
              "${user.points}",
              style: textTheme.headlineMedium,
            ),
          ),
        //choose
        DataCell(
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return DropDownWidget<String>(
                hintText: "+/-",
                height: 40,
                width: 60,
                items: const ["+", "-"],
                textStyle: textTheme.displayLarge,
                onChanged: (v) => context.read<UserBloc>().add(
                      ChangeIORDEvent(
                        value: v ?? "",
                        userId: user.id,
                      ),
                    ),
                value: getIorD(state, user.id),
              );
            },
          ),
        ),
        //enter point
        DataCell(
          TextFormField(
            cursorHeight: 15,
            initialValue: "",
            onChanged: (v) =>
                context.read<UserBloc>().add(ChangeInputPointEvent(
                      value: int.tryParse(v) ?? 0,
                      userId: user.id,
                    )),
            decoration: const InputDecoration(
              hintText: "0",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(
                left: 10,
              ),
            ),
          ),
        ),
        //action
        DataCell(ElevatedButton(
            onPressed: () => context.read<UserBloc>().add(UpdatePointEvent(
                  userId: user.id,
                )),
            child: Text(
              "Update",
              style: textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ))),
      ];
    });
  }

  @override
  Widget topActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopActions(
          searchHint: "Search products",
          title: "Users",
          onSearch: () => context.read<UserBloc>().add(
                SearchEvent(),
              ),
          onAddNew: () => context.read<CoreBloc>().add(
                ChangePageEvent(
                  page: PageType.editUsers,
                ),
              ),
        ),
        Wrap(
          children: [
            20.hSpace(),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return DropDownWidget(
                  hintText: "Actions",
                  items: const ["Edit", "Delete"],
                  width: 100,
                  value: state.selectedAction,
                  onChanged: (value) {
                    context
                        .read<UserBloc>()
                        .add(ChangeActionsEvent(value: value ?? ""));
                  },
                );
              },
            ),
            10.hSpace(),
            LinkTextButton(
              width: 100,
              height: 35,
              onPressed: () {
                context.read<UserBloc>().add(ActionApplyEvent());
              },
              text: "Apply",
              fillColor: linkBTNColor,
            ),
          ],
        ),
      ],
    );
  }

  String? getIorD(UserState state, int id) {
    try {
      return state.pointState[id]["choose"];
    } catch (e) {
      return null;
    }
  }
}
