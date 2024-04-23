import 'package:ecommerce_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const searchTextBorder = OutlineInputBorder(
    borderSide: BorderSide(
  color: Colors.grey,
));

enum PageType {
  allProducts,
  editProduct,
  addProduct,
  categories,
  editCategory,
  tags,
  editTag,
  attributes,
  reviews,
  editReview,
  viewMyStore,
  tax,
  shipping,
  editShipping,
  payments,
}

// ignore: constant_identifier_names
const double DESKTOP = 1262.0;
// ignore: constant_identifier_names
const double TABLET = 1145.0;
// ignore: constant_identifier_names
const double STABLET = 855.0;
// ignore: constant_identifier_names
const double XSTABLET = 722.0;
// ignore: constant_identifier_names
const double MOBILE = 467.0;

//***********Input Keys */
const String regularPrice = "regularPrice";
const String salePrice = "salePrice";
const String soldIndividualKey = "soldIndividual";
const String stockStatusKey = "stockStatus";
const String trackStock = "trackStock";
const String sku = "sku";
const String quantity = "quantity";
const String weight = "weight";
const String length = "length";
const String width = "width";
const String height = "height";
const String upSells = "upSells";
const String crossSells = "crossSells";
const String attributesKey = "attributes";
const String purchaseNote = "purchaseNote";
const String menuOrder = "menuOrder";
const String enableReview = "enableReview";
const String variationsKey = "variations";
const String productImageKey = "productImage";
const String productTagsKey = "productTags";
const String productCategoriesKey = "productCategories";
//*************** */

Future<XFile?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  // Pick an image
  return await picker.pickImage(source: ImageSource.gallery);
}

void showCannotEditMultipleItem() {
  ScaffoldMessenger.of(navigatorKey.currentContext!)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(
        "Oops!Can't edit multiple items,please select only one & try again.",
        style: Theme.of(navigatorKey.currentContext!)
            .textTheme
            .displayMedium
            ?.copyWith(
              color: Colors.red,
            ),
      ),
    ));
}

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.error,
  });
  final String error;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(error,
        style: textTheme.displaySmall?.copyWith(
          color: Colors.red,
        ));
  }
}