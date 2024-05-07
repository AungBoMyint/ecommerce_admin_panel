import 'package:ecommerce_admin/core/bloc_base/base_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/form_error_conditions.dart';
import 'package:ecommerce_admin/core/presentation/widgets/row_link_btn.dart';
import 'package:ecommerce_admin/coupons/bloc/coupon_bloc.dart';
import 'package:ecommerce_admin/coupons/presentation/widgets/coupon_general_body.dart';
import 'package:ecommerce_admin/coupons/presentation/widgets/coupon_usage_description.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class CouponForm extends StatelessWidget {
  const CouponForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    final isMSTABLET = size.width < MSTABLET;
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
          Gap(20),

          //Coupon Forms
          Text(
            "Add New Coupon",
            style: textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(20),
          //Coupon Form
          SizedBox(
            width: double.infinity,
            height: 40,
            child: TextFormField(
              cursorHeight: 15,
              onChanged: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeCouponCodeEvent(value: v)),
              decoration: const InputDecoration(
                hintText: "Coupon code",
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(
                  left: 10,
                ),
              ),
            ),
          ),
          FormErrorCondition<CouponBloc, CouponState>(
              condition: (state) {
                return state.isFirstTimePressed &&
                    !(state.couponCode.error == null);
              },
              errorText: "* Coupon code is required."),
          Gap(15),
          SizedBox(
            width: double.infinity,
            height: 80,
            child: TextFormField(
              cursorHeight: 15,
              onChanged: (v) => context
                  .read<CouponBloc>()
                  .add(ChangeDescriptionEvent(value: v)),
              maxLines: 3,
              decoration: const InputDecoration(
                  hintText: "Coupon description",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  )),
            ),
          ),
          Gap(15),
          //Coupon Data Tab
          Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    BlocBuilder<CouponBloc, CouponState>(
                      builder: (context, state) {
                        return RowLinkButton(
                          iconOnly: isMSTABLET,
                          onPressed: () {
                            context.read<CouponBloc>().add(ChangeCouponDataTab(
                                tab: CouponDataTab.general));
                          },
                          text: "General",
                          icon: FontAwesomeIcons.codeFork,
                          bgColor: state.dataTab == CouponDataTab.general
                              ? Colors.white
                              : Colors.grey.shade200,
                          iColor: state.dataTab == CouponDataTab.general
                              ? Colors.grey.shade400
                              : null,
                          textStyle: state.dataTab == CouponDataTab.general
                              ? textTheme.bodyMedium
                              : null,
                        );
                      },
                    ),
                    BlocBuilder<CouponBloc, CouponState>(
                      builder: (context, state) {
                        return RowLinkButton(
                          iconOnly: isMSTABLET,
                          onPressed: () {
                            context.read<CouponBloc>().add(ChangeCouponDataTab(
                                tab: CouponDataTab.usageRestriction));
                          },
                          icon: FontAwesomeIcons.plug,
                          text: "Usage restriction",
                          bgColor:
                              state.dataTab == CouponDataTab.usageRestriction
                                  ? Colors.white
                                  : Colors.grey.shade200,
                          iColor:
                              state.dataTab == CouponDataTab.usageRestriction
                                  ? Colors.grey.shade400
                                  : null,
                          textStyle:
                              state.dataTab == CouponDataTab.usageRestriction
                                  ? textTheme.bodyMedium
                                  : null,
                        );
                      },
                    ),
                  ],
                ),

                //Data Tab Body
                BlocBuilder<CouponBloc, CouponState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: 650,
                      height:
                          state.dataTab == CouponDataTab.general ? 240 : null,
                      child: Builder(
                        builder: (context) {
                          switch (state.dataTab) {
                            case CouponDataTab.general:
                              return const CouponGeneralTabBody();
                            case CouponDataTab.usageRestriction:
                              return const CouponUsageRestrictionTabBody2();
                            default:
                              return Container();
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Gap(20),
          //sumbit button
          ElevatedButton(
            onPressed: () {
              context.read<CouponBloc>().add(AddEvent());
            },
            child: Text(
              "Save",
              style: textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap(20),
        ]).withPadding(20, 10)));
  }
}
