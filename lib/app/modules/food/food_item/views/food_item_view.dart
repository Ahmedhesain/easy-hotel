import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/utils/common.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/modules/food/food_item/views/widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/bottom_nav_bar.dart';
import '../controllers/food_item_controller.dart';
import 'widgets/addition_widget.dart';
import 'widgets/attribute_list_widget.dart';
import 'widgets/bottom_widget.dart';
import 'widgets/item_discription_widget.dart';
import 'widgets/item_images_widget.dart';
import 'widgets/reviews_widget.dart';


class FoodItemView extends GetView<FoodItemController> {
  const FoodItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        appBar: const ItemAppBar(),
        bottomNavigationBar: const AppBottomNavBar(
          index: 0,
        ),
        body: controller.loading.isTrue
            ? Center(child: Common.getSpin())
            : Stack(
                children: [
                  ListView(
                    children: [
                      const ItemImagesWidget(),
                      Padding(
                        padding: AppConstants.pagePadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ItemDescriptionWidget(),
                            const AttributeListWidget(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const TextWidget(
                                  AppStrings.reqTime,
                                  weight: FontWeight.bold,
                                  children: [TextWidget(":")],
                                ),
                                const Spacer(),
                                TextWidget(
                                  " ${controller.pro.value?.time?.toString() ?? " "} ",
                                  weight: FontWeight.bold,
                                  children: [
                                    const TextWidget(
                                      AppStrings.minutes,
                                      weight: FontWeight.bold,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const Divider(height: 10),

                            Row(
                              children: [
                                const TextWidget(
                                  AppStrings.deliveryTime,
                                  weight: FontWeight.bold,
                                  children: [TextWidget(":")],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    final selectedTime =
                                        controller.timeSelected.value;
                                    final time = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(controller.timeSelected.value),
                                      initialEntryMode:
                                          TimePickerEntryMode.input,
                                      minuteLabelText: AppStrings.minutes.tr,
                                      hourLabelText: AppStrings.hour.tr,
                                      cancelText: AppStrings.cancel.tr,
                                      confirmText: AppStrings.ok.tr,
                                      helpText: AppStrings.enterTime.tr,
                                    );
                                    selectedTime.isBefore(DateTime(
                                            selectedTime.year,
                                            selectedTime.month,
                                            selectedTime.day,
                                            (time?.hour ?? selectedTime.hour),
                                            (time?.minute ??
                                                selectedTime.minute)))
                                        ? controller.timeSelected.value =
                                            DateTime(
                                                selectedTime.year,
                                                selectedTime.month,
                                                selectedTime.day,
                                                (time?.hour ??
                                                    selectedTime.hour),
                                                (time?.minute ??
                                                    selectedTime.minute))
                                        : null;
                                  },
                                  child: TextWidget("${controller.timeSelected.value.minute} : ${controller.timeSelected.value.hour} ",
                                      weight: FontWeight.bold,
                                      ),
                                )
                              ],
                            ),
                            const Divider(height: 10),
                            const AdditionWidget(),
                            const ReviewsWidget(),
                            const SizedBox(height: 5),
                            // for (int i = 0; i < 2; i++)
                            // const ReviewWidget(),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: size.height * 0,
                      right: 0,
                      left: 0,
                      child: const BottomWidget())
                ],
              ),
      );
    });
  }
}
