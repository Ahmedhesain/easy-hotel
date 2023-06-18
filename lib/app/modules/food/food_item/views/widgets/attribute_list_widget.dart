import '../../controllers/food_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/dropdown_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_strings.dart';
import '../../../../../data/model/restaurant/dto/response/attribute_details_model.dart';

class AttributeListWidget extends GetView<FoodItemController> {
  const AttributeListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.attributeList.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextWidget(
            AppStrings.moreInformation,
            weight: FontWeight.bold,
            children: [TextWidget(":")],
          ),
          for (int i = 0; i < controller.attributeList.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: TextWidget(controller.attributeList[i].name!, size: 15 ,weight: FontWeight.bold, children: [TextWidget(":")])),
                  Expanded(
                    child: DropDownWidget<AttributeDetails>(
                      isDense: true,
                      onChanged: (value) {
                        controller.onAttributeChanged(i: i, term: value);
                      },
                      items:controller.attributeList[i].terms == null ? [] : controller.attributeList[i].terms!.map((term) => DropdownMenuItem(value: term, child: TextWidget(term.value!))).toList(),
                    ),
                  )
                ],
              ),
            ),
          const Divider(height: 10),
        ],
      ): const SizedBox.shrink();
    });
  }
}
