import 'package:easy_hotel/app/modules/food/food_cart/controllers/food_cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/cart_icon_widget.dart';
import '../../../../components/icon_button_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/resturant_controller.dart';

class RestaurantAppBar extends GetView<RestaurantController> with PreferredSizeWidget {
  const RestaurantAppBar({super.key});


  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const TextWidget(AppStrings.foodService),
        centerTitle: true,
        // actions:const [
        //  CartIconWidget()
        // ],
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);

}