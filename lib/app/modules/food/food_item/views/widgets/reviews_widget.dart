import 'package:easy_hotel/app/components/review_List_widget.dart';
import '../../controllers/food_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_strings.dart';

class ReviewsWidget extends GetView<FoodItemController> {
  const ReviewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.pro.value != null && controller.pro.value!.reviewsList != null
      ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          const TextWidget(
            AppStrings.reviews,
            weight: FontWeight.bold,
            children: [TextWidget(":")],
          ),
          ReviewsListWidget(reviewNumber: controller.pro.value?.reviewsList?.length ?? 0, reviewStars: controller.pro.value?.reviewsStars ?? 0, reviewsList: controller.pro.value?.reviewsList ?? [])
        ],
      ): SizedBox.shrink();
    });
  }
}
