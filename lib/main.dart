import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_admin/app_bloc_observer.dart';
import 'package:ecommerce_admin/category/bloc/category_bloc.dart';
import 'package:ecommerce_admin/category/presentation/widgets/categories.dart';
import 'package:ecommerce_admin/category/presentation/widgets/edit_category.dart';
import 'package:ecommerce_admin/core/bloc/core_bloc.dart';
import 'package:ecommerce_admin/core/presentation/widgets/core_bloc_builder.dart';
import 'package:ecommerce_admin/core/presentation/widgets/loading_widget.dart';
import 'package:ecommerce_admin/product/bloc/detail_product_bloc.dart';
import 'package:ecommerce_admin/product/bloc/product_bloc.dart';
import 'package:ecommerce_admin/product/presentation/widgets/add_product.dart';
import 'package:ecommerce_admin/review/presentation/widgets/edit_reviews.dart';
import 'package:ecommerce_admin/review/presentation/widgets/reviews_widget.dart';
import 'package:ecommerce_admin/settings/presentation/pages/edit_shipping_widget.dart';
import 'package:ecommerce_admin/settings/presentation/pages/shipping_widget.dart';
import 'package:ecommerce_admin/settings/presentation/pages/tax_widget.dart';
import 'package:ecommerce_admin/settings/presentation/pages/view_my_store.dart';
import 'package:ecommerce_admin/tags/presentation/widgets/edit_tags.dart';
import 'package:ecommerce_admin/tags/presentation/widgets/tags_widget.dart';
import 'package:ecommerce_admin/theme/app_theme.dart';
import 'package:ecommerce_admin/theme/colors.dart';
import 'package:ecommerce_admin/utils/app_image.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:responsive_framework/responsive_framework.dart' hide TABLET;
import 'core/presentation/widgets/app_drawer.dart';
import 'product/model/product.dart';
import 'product/presentation/widgets/product_table.dart';
import 'settings/presentation/pages/payments_widget.dart';
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

  Widget getPage(PageType pageType) {
    switch (pageType) {
      case PageType.allProducts:
        return const AllProducts();
      case PageType.categories:
        return const Categories();
      case PageType.editCategory:
        return const EditCategory();
      case PageType.editProduct:
        return const AddProduct();
      case PageType.addProduct:
        return const AddProduct();
      case PageType.tags:
        return const TagsWidget();
      case PageType.editTag:
        return const EditTag();
      case PageType.reviews:
        return ReviewsWidget(products: products);
      case PageType.editReview:
        return const EditReviews();
      case PageType.tax:
        return const TaxWidget();
      case PageType.shipping:
        return SettingShippingWidget(
          products: products,
        );
      case PageType.editShipping:
        return const EditShippingWidget();
      case PageType.payments:
        return const PaymentsWidget();
      case PageType.viewMyStore:
        return const ViewMyStore();
      default:
        return Container();
    }
  }
}

class LabelDropDown extends StatelessWidget {
  const LabelDropDown({
    super.key,
    required this.label,
    required this.items,
    required this.hintText,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final List<String> items;
  final String hintText;
  final String? value;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(builder: (context, constraints) {
      log("Label Column's MaxWidth: ${constraints.maxWidth}");
      return ResponsiveRowColumn(
        layout: constraints.maxWidth > 450
            ? ResponsiveRowColumnType.ROW
            : ResponsiveRowColumnType.COLUMN,
        columnCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label.isEmpty
              ? const ResponsiveRowColumnItem(child: Gap(0))
              : ResponsiveRowColumnItem(
                  child: Text(
                    label,
                    style: textTheme.bodyLarge,
                  ),
                ),
          label.isEmpty
              ? const ResponsiveRowColumnItem(child: Gap(0))
              : const ResponsiveRowColumnItem(
                  child: SizedBox(
                  height: 5,
                  width: 40,
                )),
          ResponsiveRowColumnItem(
            child: DropDownWidget(
              hintText: hintText,
              height: 40,
              items: items,
              onChanged: onChanged,
              value: value,
            ),
          ),
        ],
      );
    });
  }
}

class MainTitleText extends StatefulWidget {
  const MainTitleText({
    super.key,
    required this.e,
    this.onEdit,
    this.onDelete,
  });

  final String e;
  final void Function()? onEdit;
  final void Function()? onDelete;

  @override
  State<MainTitleText> createState() => _MainTitleTextState();
}

class _MainTitleTextState extends State<MainTitleText> {
  bool isHover = false;
  void changeHover(bool v) {
    if (mounted) {
      setState(() {
        isHover = v;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onExit: (e) => changeHover(false),
      onHover: (e) => changeHover(true),
      child: InkWell(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.e,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: textTheme.headlineMedium?.copyWith(
                decoration: isHover ? TextDecoration.underline : null,
                decorationColor: linkBTNColor,
                color: linkBTNColor,
                fontWeight: isHover ? FontWeight.bold : null,
              ),
            ),
            isHover ? 10.vSpace() : 0.vSpace(),
            isHover
                ? Row(
                    children: [
                      InkWell(
                        onTap: widget.onEdit,
                        child: Text(
                          "Edit",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: linkBTNColor),
                        ),
                      ),
                      10.hSpace(),
                      InkWell(
                        onTap: widget.onDelete,
                        child: Text(
                          "Delete",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: linkBTNColor),
                        ),
                      ),
                    ],
                  )
                : 0.vSpace(),
          ],
        ),
      ),
    );
  }
}

class LinkTextButton extends StatelessWidget {
  const LinkTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.height,
    this.color,
    this.fillColor,
  });
  final void Function()? onPressed;
  final String text;
  final double? height;
  final Color? color;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: fillColor,
            border: Border.all(
              color: color ?? linkBTNColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                5,
              ),
            )),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Center(
          child: Text(
            text,
            style: textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: fillColor == null ? (color ?? linkBTNColor) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.hintText,
    required this.items,
    this.width,
    this.height,
    this.hintStyle,
    this.value,
    this.onChanged,
  });

  final String hintText;
  final List<String> items;
  final double? width;
  final double? height;
  final TextStyle? hintStyle;
  final String? value;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: false,
        hint: Text(
          hintText,
          style: hintStyle ?? textTheme.bodyMedium,
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(
            left: 5,
          ),
          height: height ?? 35,
          width: width ?? 160,
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade500,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  5,
                ),
              )),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
      ),
    );
  }
}
