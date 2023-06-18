

import 'package:easy_hotel/app/modules/food/food_cart/controllers/food_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/product_card_vertical_list.dart';

class ItemListWidget extends GetView<FoodCartController> {
  const ItemListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Obx(() {
      final product = controller.cartList;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (int i = 0; i < product.length; i++)
            Dismissible(
              key: product[i].selectedVariation != null ? Key('${product[i].name}.${product[i].id}') : Key('${product[i].id}'),
              onDismissed: (dir) {
                controller.remove(i);
              },
              background: Container(
                height: size.height * 0.15,
                color: Colors.red.withOpacity(0.8),
              ),
              child: SizedBox(
                  width: size.width,
                  child: ProductCard(
                      size,
                      product[i],
                      product[i].fav,
                      product[i].quantity?.toString() ?? 1.toString(),
                          () {},
                      true
                  )),
            )
        ],
      );
    });
  }
}
