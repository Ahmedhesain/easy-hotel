import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/values/app_strings.dart';
import '../modules/food/food_cart/controllers/food_cart_controller.dart';
import '../routes/app_pages.dart';

class AppBottomNavBar extends GetView<FoodCartController> {
  // ignore: use_key_in_widget_constructors
  const AppBottomNavBar({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                label: '',
                tooltip: ""),
            BottomNavigationBarItem(
                icon: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextWidget(
                        controller.cartList.length.toString(),
                        weight: FontWeight.bold,
                      ),
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                label: "",
                tooltip: ""),
            const BottomNavigationBarItem(
                icon: SizedBox(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                label: "",
                tooltip: ""),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                label: "",
                tooltip: ""),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.contact_support,
                  color: Colors.black,
                ),
                label: "",
                tooltip: ""),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                label: '',
                tooltip: ""),
          ],
          onTap: (index) => ontap(index),
          currentIndex: index,
          iconSize: 24,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
        ));
  }

  ontap(int index) {
    switch (index) {
      case 0:
        Get.toNamed(Routes.ALLSERVICES);
        break;
      case 1:
        Get.toNamed(Routes.FOOD_CART);
        break;
      case 2:
        Get.toNamed(Routes.FAV_PRODUCTS);
        break;
      case 3:
        Get.toNamed(Routes.SETTINGS);
        break;
      case 4:
        Get.toNamed(Routes.CONTACT_US);
        break;
      case 5:
        Get.toNamed(Routes.MY_ACCOUNT);
        break;
    }
  }
}
