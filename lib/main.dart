import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_admin/app_bloc_observer.dart';
import 'package:ecommerce_admin/category/bloc/category_bloc.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/core_bloc_builder.dart';
import 'package:ecommerce_admin/core/presentation/widgets/loading_widget.dart';
import 'package:ecommerce_admin/coupons/bloc/coupon_bloc.dart';
import 'package:ecommerce_admin/orders/bloc/orders_bloc.dart';
import 'package:ecommerce_admin/payment/bloc/payment_bloc.dart';
import 'package:ecommerce_admin/product/bloc/detail_product_bloc.dart';
import 'package:ecommerce_admin/product/bloc/product_bloc.dart';
import 'package:ecommerce_admin/review/bloc/review_bloc.dart';
import 'package:ecommerce_admin/theme/app_theme.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/user/bloc/user_bloc.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'core/data/functions.dart';
import 'core/presentation/widgets/app_drawer.dart';
import 'product/model/product.dart';
import 'shipping/bloc/shipping_bloc.dart';
import 'tags/bloc/tag_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();

void main() {
  runZonedGuarded(() {
    WidgetsFlutterBinding.ensureInitialized();
    Bloc.observer = AppBlocObserver();
    runApp(const MyApp());
  }, (error, stack) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CoreBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => DetailProductBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => TagBloc()),
        BlocProvider(create: (context) => ReviewBloc()),
        BlocProvider(create: (context) => ShippingBloc()),
        BlocProvider(create: (context) => CouponBloc()),
        BlocProvider(create: (context) => PaymentBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => UserBloc()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme(),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This widget is the root of your application.
  @override
  void initState() {
    initProducts();
    super.initState();
  }

  bool loading = true;
  List<Product> products = [];

  Future<void> initProducts() async {
    final pl = await getProducts(0);
    if (mounted) {
      setState(() {
        loading = false;
        products = pl;
      });
    }
  }

  Future<List<Product>> getProducts(int v) async {
    final productsJson =
        await rootBundle.loadString("assets/mock/product_mock.json");
    final List<dynamic> results = jsonDecode(productsJson);
    products = results.map((e) => Product.fromJson(e)).toList();
    products.removeRange(20, 1000);
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final darkTextTheme = AppTheme.darkTheme().textTheme;
    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        drawer: size.width < TABLET ? const AppDrawer() : null,
        appBar: AppBar(
          backgroundColor: majorBGColor,
          leadingWidth: size.width < TABLET ? 35 : 200,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: size.width < TABLET
                ? Builder(builder: (c) {
                    return InkWell(
                      onTap: () {
                        log("Pressing Drawer to Open........");
                        Scaffold.of(c).openDrawer();
                      },
                      child: Image.asset(
                        AppImage.drawer,
                        width: 35,
                        height: 35,
                      ),
                    );
                  })
                : Row(
                    children: [
                      //Admin Name
                      Text(
                        "David Willian",
                        style: darkTextTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const Gap(20),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Image.asset(AppImage.emptyProfile),
                      ),
                    ],
                  ),
          ),
          centerTitle: true,
          title: Text(
            "Shoppify Ecommerce Store",
            style: darkTextTheme.displayLarge,
          ),
          actions: [
            //Notifications
            SizedBox(
              width: 50,
              height: 50,
              child: Stack(
                children: [
                  //Noti Icon
                  const Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        FontAwesomeIcons.bell,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  //Noti Count
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: linkBTNColor,
                      radius: 10,
                      child: Text(
                        "10",
                        style: textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.hSpace(),
            //Logout Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Text(
                "Log Out",
                style: textTheme.bodyMedium,
              ),
            ),
            20.hSpace(),
          ],
        ),
        body: Center(
          child: loading
              ? const LoadingWidget()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Drawer
                    if (size.width > TABLET) ...[const AppDrawer()],
                    CoreBlocBuilder(builder: (state) {
                      return getPage(state.page);
                    }),
                  ],
                ),
        ));
  }
}
