import 'dart:developer';
import 'dart:io';

import 'package:ecommerce_admin/core/data/form_data.dart';
import 'package:ecommerce_admin/core/presentation/widgets/link_text_button.dart';
import 'package:ecommerce_admin/utils/extensions.dart';
import 'package:ecommerce_admin/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductImage extends StatefulWidget {
  const ProductImage({
    super.key,
  });

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  String? productImage;

  @override
  void initState() {
    getProductImage();
    super.initState();
  }

  Future<void> takePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (!(result == null)) {
      /* File file = File(result.files.single.path ?? ""); */
      setState(() {
        productImage = result.files.single.path;
      });
      formData[productImageKey] = productImage;
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
          child: Text(
            "Product image",
            style: textTheme.bodyMedium,
          ),
        ),
        LinkTextButton(
                onPressed: () {
                  takePicture();
                },
                text: "pick an image")
            .withPadding(20, 10),
        //Picked Image
        !(productImage == null)
            ? Stack(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.grey,
                    )),
                    child: Image.file(
                      File(productImage!),
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          productImage = null;
                        });
                      }
                    },
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                        child: Icon(
                          // ignore: deprecated_member_use
                          FontAwesomeIcons.remove,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    ).withElevation(
        border: Border.all(
      color: Colors.grey,
    ));
  }

  void getProductImage() {
    try {
      productImage = formData[productImageKey];
      if (mounted) {
        setState(() {
          productImage = productImage;
        });
      }
    } catch (e) {
      log("🍹----Error Getting Variations: $e");
    }
  }
}
