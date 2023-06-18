import 'package:easy_hotel/app/components/button_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/modules/food/food_item/controllers/food_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdditionsDialog extends GetView<FoodItemController> {
  const AdditionsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius)
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                padding: AppConstants.pagePadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const TextWidget("النوع:", weight: FontWeight.bold, size: 14),
                          Wrap(
                            spacing: 5,
                            runSpacing: -10,
                            children: [
                              for(int i = 0; i < controller.pro.value!.addititonsList!.length; i++)
                                GestureDetector(
                                  onTap: () => controller.changeAddition(controller.pro.value!.addititonsList![i]),
                                  child: Chip(
                                    label: TextWidget(controller.pro.value!.addititonsList![i].name!, textColor: Colors.black,),
                                    backgroundColor:controller.selectedAdditions.contains(controller.pro.value!.addititonsList![i]) ? Theme
                                        .of(context)
                                        .primaryColor : Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                                  ),
                                )
                            ],
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
            Padding(
              padding: AppConstants.pagePadding,
              child: ButtonWidget(
                text: AppStrings.close,
                onPressed: () {
                  Get.back();
                },
                expanded: true,
              ),
            ),
          ],
        ),
      );
    });
  }
}
