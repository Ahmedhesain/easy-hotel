import 'package:easy_hotel/app/components/icon_button_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/modules/food/food_cart/views/widgets/items_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/bottom_nav_bar.dart';
import '../../../../core/utils/common.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/food_cart_controller.dart';

class FoodCartView extends GetView<FoodCartController> {
  const FoodCartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.foodCart),
            centerTitle: true,
            actions: [
              // Center(
              //   child: UnconstrainedBox(
              //     child: IconButtonWidget(
              //       icon: Icons.history_rounded,
              //       onPressed: () => controller.removeAll(),
              //     ),
              //   ),
              // )
            ],
          ),
          bottomNavigationBar: const AppBottomNavBar(
            index: 1,
          ),
          body: controller.isLoading.isTrue
              ? Center(child: Common.getSpin())
              : DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // BoxWidget)(
                      //   height: 50,
                      //   margin: const EdgeInsets.fromLTRB(AppConstants.padding, 10, AppConstants.padding, 0),
                      //   shadowColor: Colors.transparent,
                      //   radius: AppConstants.radius,
                      //   color: Colors.transparent,
                      //   borderColor: AppColors.grey,
                      //   borderWidth: 2,
                      //   // clipBehavior: Clip.antiAliasWithSaveLayer,
                      //   child: TabBar(
                      //       // controller: controller.tabController,
                      //       unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.5),
                      //       labelColor: Theme.of(context).primaryColor,
                      //       indicatorColor: Colors.transparent,
                      //       indicatorWeight: 0.01,
                      //       onTap: (value){},
                      //       tabs: const <Tab>[
                      //         Tab(child: TextWidget(AppStrings.preparing, size: 13)),
                      //         Tab(child: TextWidget(AppStrings.delivering, size:13)),
                      //         Tab(child: TextWidget(AppStrings.delivered, size:13)),
                      //       ]
                      //   ),
                      // ) ,
                      const ItemListWidget(),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  const TextWidget(
                                    AppStrings.totalPrice,
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                                    child: Obx(() => TextWidget(
                                          controller.totalPrice.value
                                              .toString(),
                                          size: 18,
                                          weight: FontWeight.bold,
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                                    child: TextWidget(
                                      controller.user.selectedBranch
                                              ?.currencyName ??
                                          AppStrings.LE,
                                      size: 18,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Center(
                                child: TextButton(
                                    onPressed: () => Get.toNamed(
                                        Routes.FOOD_CHECKOUT,
                                        arguments: controller.cartList),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(AppColors
                                                .restaurantThirdColor)),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                                      child: TextWidget(
                                        AppStrings.confirmCart,
                                        size: 18,
                                        weight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ));
  }
}
