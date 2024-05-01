import 'package:ecommerce_admin/category/presentation/widgets/categories.dart';
import 'package:ecommerce_admin/category/presentation/widgets/edit_category.dart';
import 'package:ecommerce_admin/product/presentation/widgets/add_product.dart';
import 'package:ecommerce_admin/product/presentation/widgets/product_table.dart';
import 'package:ecommerce_admin/review/presentation/widgets/edit_reviews.dart';
import 'package:ecommerce_admin/review/presentation/widgets/reviews_widget.dart';
import 'package:ecommerce_admin/tags/presentation/widgets/tags_widget.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../coupons/presentation/pages/coupons_page.dart';
import '../../settings/presentation/pages/edit_shipping_widget.dart';
import '../../settings/presentation/pages/payments_widget.dart';
import '../../settings/presentation/pages/shipping_widget.dart';
import '../../settings/presentation/pages/view_my_store.dart';
import '../../tags/presentation/widgets/edit_tags.dart';

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
      return const ReviewsWidget(
        products: [],
      );
    case PageType.editReview:
      return const EditReviews();
    /* case PageType.tax:
        return const TaxWidget(); */
    case PageType.shipping:
      return const SettingShippingWidget();
    case PageType.editShipping:
      return const EditShippingWidget();
    case PageType.payments:
      return const PaymentsWidget();
    case PageType.viewMyStore:
      return const ViewMyStore();
    case PageType.coupons:
      return const CouponsPage();
    case PageType.editCoupons:
      return Container();
    default:
      return Container();
  }
}
