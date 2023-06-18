
import '../../controllers/food_item_controller.dart';
import 'package:easy_hotel/app/modules/my_account/fav_products/controllers/fav_products_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../components/icon_button_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_constants.dart';
import '../../../../../core/values/app_strings.dart';
class BottomWidget extends GetView<FoodItemController> {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return Container(
        height: 60,
        decoration: BoxDecoration(
            color: Theme
                .of(context)
                .colorScheme
                .primary.withOpacity(0.9),
            borderRadius:  const BorderRadius.vertical(top: Radius.circular(AppConstants.radius)),
            boxShadow: [BoxShadow(color: Theme
                .of(context)
                .shadowColor, offset: const Offset(0, 0), spreadRadius: 5, blurRadius: 8)
            ]),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               TextWidget(
          controller.pro.value == null ? "" :  controller.pro.value!.sumPrice.toString(),
                height: 1,
                weight: FontWeight.bold,
                size: 20,
                children: [TextWidget(controller.user.selectedBranch?.currencySubName ?? AppStrings.LE)],
              ),
              const Spacer(),
              IconButtonWidget(
                icon: Icons.add_shopping_cart_rounded,
                iconSize: 25,
                onPressed: () => controller.addToCart(),
              )
            ],
          ),
        ),
      );
    });
  }
}
