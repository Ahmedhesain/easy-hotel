import 'package:get/get.dart';

import '../controllers/food_item_controller.dart';

class FoodItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodItemController>(
      () => FoodItemController(),
    );
  }
}
