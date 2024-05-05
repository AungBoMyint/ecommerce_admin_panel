import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/core/presentation/widgets/responsive_rowcolumn_textfield.dart';
import 'package:ecommerce_admin/user/bloc/user_bloc.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add User",
              style: textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              return ResponsiveRowColumnTextField(
                isExpanded: false,
                rowSpace: 80,
                textFieldWidth: size.width * 0.5,
                textFieldHeight: 45,
                hasFormError: (state.isFirstTimePressed &&
                    !(state.fullName.error == null)),
                label: "Full Name",
                labelWidth: 200,
                errorText: "* Full name is required.",
                onChanged: (v) => context.read<UserBloc>().add(
                      ChangeFullNameEvent(value: v),
                    ),
              );
            }),
            const Gap(20),
            BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              return ResponsiveRowColumnTextField(
                isExpanded: false,
                rowSpace: 80,
                textFieldWidth: size.width * 0.5,
                textFieldHeight: 45,
                hasFormError: (state.isFirstTimePressed &&
                    !(state.phoneNumber.error == null)),
                label: "Phone Number",
                labelWidth: 200,
                errorText: "* Phone number is required.",
                onChanged: (v) => context.read<UserBloc>().add(
                      ChangePhoneNumberEvent(value: v),
                    ),
              );
            }),
            const Gap(20),
            BlocBuilder<UserBloc, UserState>(builder: (context, state) {
              return ResponsiveRowColumnTextField(
                isExpanded: false,
                rowSpace: 80,
                textFieldWidth: size.width * 0.5,
                textFieldHeight: 45,
                hasFormError: false,
                label: "Points",
                labelWidth: 200,
                errorText: "",
                onChanged: (v) => context.read<UserBloc>().add(
                      ChangePointEvent(value: int.tryParse(v) ?? 0),
                    ),
              );
            }),
            Gap(20),
            //Profile
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Profile",
                      style: textTheme.bodyLarge,
                    ),
                    const Gap(8),
                    LinkTextButton(
                        onPressed: () {
                          context.read<UserBloc>().add(PickImageEvent());
                        },
                        text: "Pick profile image")
                  ],
                ),
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  return ((state.isFirstTimePressed) &&
                          !(state.profile.error == null))
                      ? const ErrorText(error: "* Profile Image is required.")
                      : 0.vSpace();
                }),
                const Gap(10),
                BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                  if (state.profile.value == null) {
                    return Image.asset(
                      AppImage.picture,
                      height: 100,
                    );
                  } else {
                    return Image.memory(
                      state.profile.value!,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  }
                })
              ],
            ),

            Gap(40),
            //Submitted Button
            ElevatedButton(
                onPressed: () => context.read<UserBloc>().add(AddEvent()),
                child: Text(
                  "Submit",
                  style: textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ).withPadding(20, 20),
      );
    });
  }
}
