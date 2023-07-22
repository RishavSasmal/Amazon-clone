import 'dart:io';

import 'package:backend_prac/constants/utils.dart';
import 'package:backend_prac/feature/admin/services/admin_services.dart';
import 'package:backend_prac/widgets/custom_button.dart';
import 'package:backend_prac/widgets/custom_text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();
  final AdminServices adminServices = AdminServices();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];

  String category = 'Mobiles';

  List<File> images = [];
  void sellProduct() {
    adminServices.sellProduct(
      context: context,
      name: productNameController.text,
      description: descriptionController.text,
      price: double.parse(priceController.text),
      quantity: double.parse(quantityController.text),
      category: category,
      images: images,
    );
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Center(child: Text('Add Product')),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                images.isEmpty
                    ? GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : CarouselSlider(
                        items: images.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Image.file(
                                i,
                                fit: BoxFit.cover,
                                // width: double.infinity,
                                // height: 200,
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                            height: 200.0, viewportFraction: 1)),
                const SizedBox(height: 30),
                CustomTextField(
                    controller: productNameController,
                    hintText: "Product Name"),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: descriptionController,
                  hintText: "Descriptions",
                  maxLine: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: priceController, hintText: " Enter Price"),
                const SizedBox(height: 10),
                CustomTextField(
                    controller: quantityController,
                    hintText: " Enter Quantity"),
                SizedBox(
                  // height: 10,
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        category = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                    text: "Sell",
                    onTap: () {
                      if (_addProductFormKey.currentState!.validate() &&
                          images.isNotEmpty) {
                        sellProduct();
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
