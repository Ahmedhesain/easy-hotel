
import '../../controllers/food_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_constants.dart';
import '../../../../../core/values/app_strings.dart';
import '../../../../resturant/views/widgets/offer_card.dart';

class RelatedItemWidget extends GetView<FoodItemController> {
  const RelatedItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.groupItems.isNotEmpty ? Column(
      children: [
         const TextWidget(
          AppStrings.relatedItems,
          weight: FontWeight.bold,
          children: [TextWidget(":")],
        ),
        const SizedBox(height: 5),
        Transform.scale(
          scaleX: 1.1,
          child: SizedBox(
            height:controller.groupItems.isNotEmpty ? 110 : 0,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding:  const EdgeInsets.symmetric(horizontal: AppConstants.padding),
              itemCount: controller.groupItems.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return  OfferCard(item: controller.groupItems[index],);
              },
            ),
          ),
        ),
        const Divider(height: 10),
      ],
    ): const SizedBox.shrink();
  }
}
