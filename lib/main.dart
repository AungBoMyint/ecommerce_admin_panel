import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:ecommerce_admin/app_bloc_observer.dart';
import 'package:ecommerce_admin/category/bloc/category_bloc.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/core_bloc_builder.dart';
import 'package:ecommerce_admin/core/presentation/widgets/loading_widget.dart';
import 'package:ecommerce_admin/coupons/bloc/coupon_bloc.dart';
import 'package:ecommerce_admin/product/bloc/detail_product_bloc.dart';
import 'package:ecommerce_admin/product/bloc/product_bloc.dart';
import 'package:ecommerce_admin/review/bloc/review_bloc.dart';
import 'package:ecommerce_admin/settings/bloc/shipping_bloc.dart';
import 'package:ecommerce_admin/theme/app_theme.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/data/functions.dart';
import 'core/presentation/widgets/app_drawer.dart';
import 'product/model/product.dart';
import 'product/presentation/widgets/product_table.dart';
import 'settings/presentation/pages/payments_widget.dart';
import 'tags/bloc/tag_bloc.dart';
import 'tags/presentation/widgets/tags_widget.dart';

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
    return Scaffold(
        drawer: size.width < TABLET ? const AppDrawer() : null,
        appBar: AppBar(
          backgroundColor: majorBGColor,
          leadingWidth: 35,
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
                : Image.asset(
                    AppImage.logo,
                    width: 35,
                    height: 35,
                  ),
          ),
          centerTitle: false,
          title: Text(
            "Shopify Ecommerce",
            style: darkTextTheme.displaySmall,
          ),
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
