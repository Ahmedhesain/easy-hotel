import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../../../components/text_field_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_colors.dart';
import '../../controllers/my_orders_detail_controller.dart';

class OrderReviewWidget extends GetView<MyOrdersDetailController> {
  const OrderReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title:  Center(
            child: TextWidget(
 controller.orderDetail?.reviewId == null ? AppStrings.saveReview :  AppStrings.editReview,
          weight: FontWeight.bold,
        )),
        content: SizedBox(
          height: size.height * .4,
          width: size.width,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // TextWidget(
                //   controller.orderDetail?.reviewId == null ? AppStrings.saveReview :  AppStrings.editReview,
                //   size: 20,
                //   weight: FontWeight.bold,
                // ),
                Obx(() => Container(
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.03),
                          color: AppColors.appGreyLight),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: Column(
                            children: [
                              RatingBar.builder(
                                initialRating: controller.orderDetail?.rate ?? 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemSize: size.width * 0.1,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.stars,
                                  color: AppColors.colorLogo,
                                ),
                                onRatingUpdate: (value) => controller
                                    .chnageStars(value.toInt()),
                              ),
                              TextWidget(
                                "${controller.stars.value}" +
                                    " نجوم",
                                textColor: Colors.grey,
                                size: 16,
                                weight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                TextWidget(
                  controller.orderDetail?.reviewId == null ? AppStrings.saveReview :  AppStrings.editReview,
                  size: 20,
                  weight: FontWeight.bold,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 100,
                    child: TextFieldWidget(
                      maxLines: 5,
                      controller: controller.comment,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Center(
            child: Container(
                height: size.height * .06,
                width: size.width * .4,
                decoration:  BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(6.00)),
                  color: controller.orderDetail?.reviewId == null ? AppColors.appHallsRedDark:  AppColors.restaurantThirdColor ,
                ),
                child: TextButton(
                  child:  Center(
                      child: TextWidget(
                    controller.orderDetail?.reviewId == null ? AppStrings.saveReview :  AppStrings.editReview,
                    textColor: Colors.white,
                    size: 15,
                    weight: FontWeight.bold,
                  )),
                  onPressed: () {
                    controller.saveReview();
                  },
                )),
          ),
        ],
      );
    });
    ;
  }
}
