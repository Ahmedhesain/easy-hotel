import '../../controllers/food_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../components/icon_button_widget.dart';
import '../../../../../core/utils/restaurant_strorage.dart';

class ItemAppBar extends GetView<FoodItemController> with PreferredSizeWidget {
  const ItemAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AppBar(
          title: Text(
              controller.pro.value == null ? "" : controller.pro.value!.name!),
          // centerTitle: true,
          actions: [
            UnconstrainedBox(
              child: Obx(() => IconButtonWidget(
                    icon:(controller.pro.value?.fav.value ?? false) == false ?
                     Icons.favorite_border_rounded:
                     Icons.favorite,
                    onPressed: () {
                      RestaurantStorage.addItemToFavorite(
                          controller.pro.value!);
                      controller
                          .pro.value?.fav(!controller.pro.value!.fav.value);
                      controller.pro.value?.fav.refresh();
                    },
                  )),
            ),
            const SizedBox(width: 10),
          ],
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
