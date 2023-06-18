import '../../controllers/food_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_strings.dart';

class ItemDescriptionWidget extends GetView<FoodItemController> {
  const ItemDescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.pro.value != null && controller.pro.value!.discribtion != null && controller.pro.value!.discribtion!.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            AppStrings.description,
            weight: FontWeight.bold,
            children: [TextWidget(":")],
          ),
          TextWidget(
              controller.pro.value!.discribtion!,
              height: 1.5),
          const Divider(height: 10),
        ],
      ):const SizedBox.shrink();
    });
  }
}
