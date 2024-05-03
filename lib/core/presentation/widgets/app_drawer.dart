import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/active_drawer_item_painter.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/utils.dart';
import 'core_bloc_builder.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: majorBGColor,
      clipBehavior: Clip.none,
      shape: const RoundedRectangleBorder(),
      width: 160,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomPaint(
              foregroundPainter:
                  size.width > TABLET ? ActiveDrawerItemPainter() : null,
              child: Container(
                color: linkBTNColor,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AppImage.product,
                      width: 30,
                      height: 30,
                    ),
                    10.hSpace(),
                    Text(
                      "Products",
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Product's Functions
            Container(
              color: minorBGColor,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: /* ClayContainer(
                color: minorBGColor,
                
                child: */ /* Padding(
                  padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
                  child:  */
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CoreBloc, CoreState>(builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        context
                            .read<CoreBloc>()
                            .add(ChangePageEvent(page: PageType.allProducts));
                      },
                      child: Text(
                        "All Products",
                        style: textTheme.displaySmall?.copyWith(
                          color: ((state.page == PageType.allProducts) ||
                                  (state.page == PageType.editProduct))
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: ((state.page == PageType.allProducts) ||
                                  (state.page == PageType.editProduct))
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    );
                  }),
                  15.vSpace(),
                  BlocBuilder<CoreBloc, CoreState>(builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        context
                            .read<CoreBloc>()
                            .add(ChangePageEvent(page: PageType.addProduct));
                      },
                      child: Text(
                        "Add New",
                        style: textTheme.displaySmall?.copyWith(
                          color: state.page == PageType.addProduct
                              ? Colors.white
                              : Colors.grey.shade400,
                        ),
                      ),
                    );
                  }),
                  15.vSpace(),
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      context
                          .read<CoreBloc>()
                          .add(ChangePageEvent(page: PageType.categories));
                    },
                    child: CoreBlocBuilder(builder: (state) {
                      return Text(
                        "Categories",
                        style: textTheme.displaySmall?.copyWith(
                          color: (state.page == PageType.categories ||
                                  state.page == PageType.editCategory)
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: (state.page == PageType.categories ||
                                  state.page == PageType.editCategory)
                              ? FontWeight.bold
                              : null,
                        ),
                      );
                    }),
                  ),
                  15.vSpace(),
                  BlocBuilder<CoreBloc, CoreState>(builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        context.read<CoreBloc>().add(
                              ChangePageEvent(page: PageType.tags),
                            );
                      },
                      child: Text(
                        "Tags",
                        style: textTheme.displaySmall?.copyWith(
                          color: (state.page == PageType.tags ||
                                  state.page == PageType.editTag)
                              ? Colors.white
                              : Colors.grey.shade400,
                        ),
                      ),
                    );
                  }),
                  15.vSpace(),
                  InkWell(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      context
                          .read<CoreBloc>()
                          .add(ChangePageEvent(page: PageType.orders));
                    },
                    child: CoreBlocBuilder(builder: (state) {
                      return Text(
                        "Orders",
                        style: textTheme.displaySmall?.copyWith(
                          color: (state.page == PageType.orders ||
                                  state.page == PageType.editOrders)
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: (state.page == PageType.orders ||
                                  state.page == PageType.editOrders)
                              ? FontWeight.bold
                              : null,
                        ),
                      );
                    }),
                  ),
                  15.vSpace(),
                  BlocBuilder<CoreBloc, CoreState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                          context.read<CoreBloc>().add(
                                ChangePageEvent(page: PageType.reviews),
                              );
                        },
                        child: Text(
                          "Reviews",
                          style: textTheme.displaySmall?.copyWith(
                            color: (state.page == PageType.reviews ||
                                    state.page == PageType.editReview)
                                ? Colors.white
                                : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            /* ), */
            /* ), */
            /* Gap(20),
            15.vSpace(), */
            CustomPaint(
              foregroundPainter:
                  size.width > TABLET ? ActiveDrawerItemPainter() : null,
              child: Container(
                color: linkBTNColor,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.gear,
                      size: 25,
                      color: Colors.white,
                    ),
                    10.hSpace(),
                    Text(
                      "Settings",
                      style: textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: minorBGColor,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<CoreBloc, CoreState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          Scaffold.of(context).closeDrawer();
                          context.read<CoreBloc>().add(
                                ChangePageEvent(page: PageType.coupons),
                              );
                        },
                        child: Text(
                          "Coupons",
                          style: textTheme.displaySmall?.copyWith(
                            color: (state.page == PageType.coupons ||
                                    state.page == PageType.editCoupons)
                                ? Colors.white
                                : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ),
                  /* 15.vSpace(),
                  //Tax
                  BlocBuilder<CoreBloc, CoreState>(builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        context
                            .read<CoreBloc>()
                            .add(ChangePageEvent(page: PageType.tax));
                      },
                      child: Text(
                        "Tax",
                        style: textTheme.displaySmall?.copyWith(
                          color: state.page == PageType.tax
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: (state.page == PageType.tax)
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    );
                  }),
 */
                  15.vSpace(),
                  //Shipping
                  BlocBuilder<CoreBloc, CoreState>(builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        context
                            .read<CoreBloc>()
                            .add(ChangePageEvent(page: PageType.shipping));
                      },
                      child: Text(
                        "Shipping",
                        style: textTheme.displaySmall?.copyWith(
                          color: (state.page == PageType.shipping ||
                                  state.page == PageType.editShipping)
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: ((state.page == PageType.shipping ||
                                  state.page == PageType.editShipping))
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    );
                  }),

                  15.vSpace(),
                  BlocBuilder<CoreBloc, CoreState>(builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        context
                            .read<CoreBloc>()
                            .add(ChangePageEvent(page: PageType.payments));
                      },
                      child: Text(
                        "Payments",
                        style: textTheme.displaySmall?.copyWith(
                          color: state.page == PageType.payments
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: (state.page == PageType.payments)
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    );
                  }),
                  15.vSpace(),
                  //View My Store
                  BlocBuilder<CoreBloc, CoreState>(builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        context
                            .read<CoreBloc>()
                            .add(ChangePageEvent(page: PageType.viewMyStore));
                      },
                      child: Text(
                        "View my store",
                        style: textTheme.displaySmall?.copyWith(
                          color: (state.page == PageType.viewMyStore)
                              ? Colors.white
                              : Colors.grey.shade400,
                          fontWeight: (state.page == PageType.viewMyStore)
                              ? FontWeight.bold
                              : null,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
