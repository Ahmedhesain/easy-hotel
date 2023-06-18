import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_hotel/app/core/utils/common.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';
import '../../controllers/food_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../../../../components/icon_button_widget.dart';
import '../../../../../components/image_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_assets.dart';

class ItemImagesWidget extends GetView<FoodItemController> {
  const ItemImagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      if (controller.loading.isTrue) {
        return SizedBox(height: 150, child: Common.getSpin());
      }
      return Stack(
        clipBehavior: Clip.none,
        children: [
          CarouselSlider.builder(
            itemCount: controller.pro.value != null
                ? controller.pro.value!.itemImages!.length
                : 0,
            options: CarouselOptions(
              height: 200,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              pageSnapping: true,
              // enlargeCenterPage: true,
            ),
            itemBuilder: (context, index, _) {
              return GestureDetector(
                onTap: () {
                  Get.dialog(Dialog(
                    child: Container(
                        height: size.height * 0.6,
                        width: size.width,
                        child: CarouselSlider.builder(
                          itemCount: controller.pro.value != null
                              ? (controller.pro.value?.itemImages?.length ?? 0)
                              : 0,
                          options: CarouselOptions(
                            height: size.height * 0.6,

                            viewportFraction: 1,
                            enableInfiniteScroll: true,
                            pageSnapping: true,
                            // enlargeCenterPage: true,
                          ),
                          itemBuilder: (context, index, _) {
                            return SizedBox(
                              height: size.height * 0.6,
                              width: size.width,
                              child: PinchZoom(
                                resetDuration:
                                    const Duration(milliseconds: 100),
                                maxScale: 2.5,
                                onZoomStart: () {},
                                onZoomEnd: () {},
                                child: ImageWidget(
                                    height: size.height * 0.6,
                                    width: size.width,
                                    path: ApiProvider.imageUrl +
                                        (controller.pro.value
                                                ?.itemImages?[index].image
                                                .toString() ??
                                            ""),
                                    fit: BoxFit.fill,
                                    radius: 0),
                              ),
                            );
                          },
                        )),
                  ));
                },
                child: ImageWidget(
                    path: ApiProvider.imageUrl +
                        (controller.pro.value?.itemImages?[index].image
                                .toString() ??
                            ""),
                    fit: BoxFit.fill,
                    width: context.width,
                    radius: 0),
              );
            },
          ),
          PositionedDirectional(
            end: 10,
            bottom: -20,
            height: 40,
            width: 100,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButtonWidget(
                    icon: Icons.remove,
                    iconSize: 15,
                    iconColor: Colors.white,
                    onPressed: () => controller.decrement(),
                  ),
                  Obx(() {
                    return TextWidget("${controller.count.value}",
                        weight: FontWeight.bold, textColor: Colors.white);
                  }),
                  IconButtonWidget(
                    icon: Icons.add,
                    iconSize: 15,
                    iconColor: Colors.white,
                    onPressed: () => controller.increment(),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
