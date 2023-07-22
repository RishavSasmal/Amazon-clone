import 'package:backend_prac/feature/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variable.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://www.chooseyourmobile.com/wp-content/uploads/2020/07/Samsung-Galaxy-M31s-Blue.jpg',
      'https://www.chooseyourmobile.com/wp-content/uploads/2020/07/Samsung-Galaxy-M31s-Blue.jpg',
      'https://www.gwmobile.sg/image/cache/catalog/Banner/apple-iphone-x-64gb-gray--used--20191122085301167-1467x1600.jpg'
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        // display orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: SingleProduct(
                  image: images[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
