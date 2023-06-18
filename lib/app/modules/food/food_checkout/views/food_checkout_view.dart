import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_hotel/app/components/button_widget.dart';
import 'package:easy_hotel/app/components/icon_button_widget.dart';
import 'package:easy_hotel/app/components/text_field_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/utils/common.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/utils/validator.dart';
import 'package:easy_hotel/app/core/values/app_assets.dart';
import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_reservation/views/widgets/timer.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_services/views/widgets/price_services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../components/bottom_nav_bar.dart';
import '../../../../data/model/user/dto/response/delivery_place_response.dart';
import '../controllers/food_checkout_controller.dart';

class FoodCheckoutView extends GetView<FoodCheckoutController> {
  const FoodCheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const space = SizedBox(height: 20);

    return Scaffold(
      bottomNavigationBar: const AppBottomNavBar(index: 0,),
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: Colors.white,
          title: Column(
            children: const [
              TextWidget(
                "Checkout",
                size: 20,
              ),
              TextWidget(
                AppStrings.foodService,
                size: 15,
                textColor: AppColors.appGreyDark,
              )
            ],
          ),
        ),
        body: Obx(() => controller.loading.value == true
            ? Center(
                child: Common.getSpin(),
              )
            : Container(
                // color: AppColors.white,
                width: size.width,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.00)),
                            border:
                                Border.all(color: AppColors.black, width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const TextWidget(
                                            AppStrings.services,
                                            // textColor: AppColors.black,
                                            size: 16,
                                            weight: FontWeight.w600,
                                          ),
                                          // for(int i =0;i<controller.res[4]!.length;i++)
                                          SizedBox(
                                            width: size.width * 0.6,
                                            height: size.height * 0.2,
                                            child: ListView.builder(
                                                itemCount:
                                                    controller.cartList.length,
                                                itemBuilder: (context, i) {
                                                  var item =
                                                      controller.cartList[i];
                                                  return SizedBox(
                                                    child: Row(children: [
                                                      const Icon(
                                                        Icons
                                                            .food_bank_outlined,
                                                      ),
                                                      TextWidget(
                                                        item.name ?? "",
                                                        weight: FontWeight.bold,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        size: 17,
                                                        maxLines: 1,
                                                        children: [
                                                          TextWidget(
                                                              " ${item.sumPrice?.toString() ?? ""} LE "),
                                                          TextWidget(
                                                              " ${item.quantity?.toString() ?? "1"}X "),
                                                        ],
                                                      )
                                                    ]),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.timer),
                                      const TextWidget(
                                        AppStrings.time,
                                        // textColor: AppColors.black,
                                        size: 16,
                                        weight: FontWeight.w600,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0, 8.0, 0),
                                        child: TextWidget(
                                          intl.DateFormat("hh : mm").format(
                                              controller.cartList.last
                                                      ?.requiredDate ??
                                                  DateTime.now().add(Duration(
                                                      minutes: controller
                                                              .cartList
                                                              .last
                                                              .time ??
                                                          0))),
                                          textColor: Colors.grey,
                                          size: 16,
                                          weight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   width: size.width * 0.8,
                      //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width * 0.03,), color: AppColors.white),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10.0),
                      //     child: Center(
                      //       child: Column(
                      //         children: [
                      //
                      //           TextWidget(
                      //             " طريقه الدفع ",
                      //             textColor: Colors.black,
                      //             size: 16,
                      //             weight: FontWeight.w600,
                      //           ),
                      //           Container(width: size.width,
                      //               child:Column(children: [
                      //                 ListTile(
                      //                   title: const TextWidget('Debit',textColor: Colors.black,),
                      //                   leading: Radio<String>(
                      //                     fillColor: MaterialStateColor.resolveWith((states) => AppColors.appBlue),
                      //                     focusColor: MaterialStateColor.resolveWith((states) => AppColors.appBlue),
                      //                     value: "debit",
                      //                     groupValue: "payment",
                      //                     onChanged: ( value) {
                      //
                      //                     },
                      //                   ),
                      //                 ),
                      //                 ListTile(
                      //                   title: const TextWidget('CASH',textColor: Colors.black),
                      //                   leading: Radio<String>(
                      //                     fillColor: MaterialStateColor.resolveWith((states) => AppColors.appBlue),
                      //                     focusColor: MaterialStateColor.resolveWith((states) => AppColors.appBlue),
                      //                     value: "cash",
                      //                     groupValue: "payment",
                      //                     onChanged: ( value) {
                      //
                      //                     },
                      //                   ),
                      //                 ),
                      //               ],)
                      //
                      //
                      //
                      //           ),
                      //
                      //
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: SizedBox(
                          width: size.width * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          TextWidget(
                                            AppStrings.deliveryPlace,
                                            // textColor: AppColors.black,
                                            size: 16,
                                            weight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          width: size.width,
                                          child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                                  SizedBox(
                                                    width: size.width * 0.8,
                                                    child:
                                                        Obx(() => RadioListTile(
                                                              groupValue: controller
                                                                  .deliveryPlace
                                                                  .value,
                                                              title:
                                                                  const TextWidget(
                                                                      "الغرفة"),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .deliveryPlace
                                                                    .value = value!;
                                                                controller
                                                                    .deliveryPlaceController
                                                                    .clear();
                                                                controller
                                                                        .deliveryPlaceController
                                                                        .text =
                                                                    controller
                                                                        .roomNumber
                                                                        .value
                                                                        .toString();
                                                              },
                                                              value: 0,
                                                            )),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.8,
                                                    child:
                                                        Obx(() => RadioListTile(
                                                              groupValue: controller
                                                                  .deliveryPlace
                                                                  .value,
                                                              title:
                                                                  const TextWidget(
                                                                      "الطاولة"),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .deliveryPlace
                                                                    .value = value!;
                                                                controller
                                                                    .deliveryPlaceController
                                                                    .clear();
                                                              },
                                                              value: 1,
                                                            )),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.8,
                                                    child:
                                                        Obx(() => RadioListTile(
                                                              groupValue: controller
                                                                  .deliveryPlace
                                                                  .value,
                                                              title:
                                                                  const TextWidget(
                                                                      "العنوان"),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .deliveryPlace
                                                                    .value = value!;
                                                                controller
                                                                    .deliveryPlaceController
                                                                    .text = controller
                                                                        .user
                                                                        .user
                                                                        ?.address ??
                                                                    "";
                                                              },
                                                              value: 2,
                                                            )),
                                                  ),
                                              SizedBox(
                                                width: size.width * 0.8,
                                                child: Obx(() => 
                                                    controller.palcesList.isNotEmpty ? RadioListTile(
                                                      groupValue: controller
                                                          .deliveryPlace.value,
                                                      title: const TextWidget(
                                                          "اماكن الفندق"),
                                                      onChanged: (value) {
                                                        controller.deliveryPlace
                                                            .value = value!;
                                                      },
                                                      value: 3,
                                                    ) : const SizedBox.shrink()),
                                              ),
                                            ],
                                          )),
                                      SizedBox(
                                          height: size.height * .08,
                                          width: size.width * .9,
                                          child: Obx(() {
                                            final int index =
                                                controller.deliveryPlace.value;
                                            return index == 3
                                                ? SizedBox(
                                                    height: size.height * .2,
                                                    child: ListView.builder(
                                                        itemCount: controller.palcesList.length ,
                                                        itemBuilder: (context,
                                                                i) =>
                                                            SizedBox(
                                                              width: size.width,
                                                              child: Obx(() => RadioListTile<DeliveryPlaceResponse>(
                                                      groupValue: controller
                                                          .selectedPlace.value,
                                                      title: TextWidget(
                                                         controller.palcesList[i].name),
                                                      onChanged: (value) {
                                                        controller.selectedPlace
                                                            .value = value!;
                                                      },
                                                      value: controller.palcesList[i],
                                                    )) ,
                                                            )),
                                                  )
                                                : TextFieldWidget(
                                                    
                                                    maxLines: 1,
                                                    onSubmitted: (val) => index == 0 ?  controller
                                                                          .getRoomId() : null,
                                                    // prefixWidget: index == 0
                                                    //     ? Padding(
                                                    //         padding:
                                                    //             const EdgeInsets
                                                    //                 .all(2.0),
                                                    //         child: Container(
                                                    //             height: 40,
                                                    //             width: 40,
                                                    //             decoration: BoxDecoration(
                                                    //                 color: AppColors
                                                    //                     .restaurantThirdColor,
                                                    //                 borderRadius:
                                                    //                     BorderRadius.circular(
                                                    //                         8)),
                                                    //             child:
                                                    //                 IconButton(
                                                    //               alignment:
                                                    //                   Alignment
                                                    //                       .center,
                                                    //               icon: const Icon(
                                                    //                   Icons
                                                    //                       .search),
                                                    //               onPressed: () =>
                                                    //                   controller
                                                    //                       .getRoomId(),
                                                    //             )),
                                                    //       )
                                                    //     : const SizedBox
                                                    //         .shrink(),
                                                    hint: index == 0
                                                        ? "ادخل رقم الغرفة"
                                                        : index == 1
                                                            ? "ادخل رقم الطاولة"
                                                            : index == 2
                                                                ? "ادخل العنوان"
                                                                : "",
                                                    controller: controller
                                                        .deliveryPlaceController,
                                                 textInputType: index == 0 || index == 1 ? TextInputType.number : TextInputType.text ,
                                                  );
                                          }))
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          TextWidget(
                                            AppStrings.notes,
                                            size: 16,
                                            weight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: size.height * .15,
                                          width: size.width * .9,
                                          child: TextFieldWidget(
                                            maxLines: 3,
                                            controller: controller.remark,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextWidget(
                                        AppStrings.totalPrice,
                                        // textColor: AppColors.black,
                                        size: 16,
                                        weight: FontWeight.w600,
                                      ),
                                      Obx(() => TextWidget(
                                            "  ${controller.sumPrice.value.toString()}  ",
                                            textColor: Colors.grey,
                                            size: 16,
                                            weight: FontWeight.w600,
                                            children: [
                                              TextWidget(
                                                controller.user.selectedBranch
                                                        ?.currencySubName ??
                                                    AppStrings.LE,
                                                // textColor: AppColors.black,
                                                size: 16,
                                                weight: FontWeight.w600,
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                          width: size.width * .9,
                          child: const TextWidget(
                            AppStrings.personalInfo,
                            size: 15,
                            weight: FontWeight.bold,
                          )),

                      Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.00))),
                        margin: const EdgeInsets.fromLTRB(25, 5, 25, 25),
                        padding: const EdgeInsets.all(15),
                        child: Form(
                          key: controller.registerForm,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFieldWidget(
                                controller: controller.userNameController,
                                label: AppStrings.userName,
                                suffixIcon: Icons.pin,
                                textInputAction: TextInputAction.next,
                                validator: AppValidator.forceValue,
                              ),
                              space,
                              TextFieldWidget(
                                controller: controller.nameController,
                                label: AppStrings.name,
                                suffixIcon: Icons.pin,
                                textInputAction: TextInputAction.next,
                                validator: AppValidator.forceValue,
                              ),
                              space,
                              TextFieldWidget(
                                controller: controller.emailController,
                                label: AppStrings.email,
                                suffixIcon: Icons.email,
                                textInputAction: TextInputAction.next,
                              ),
                              space,
                              TextFieldWidget(
                                controller: controller.phoneController,
                                label: AppStrings.phone,
                                suffixIcon: Icons.phone,
                                textInputAction: TextInputAction.next,
                                justNumbers: true ,
                                textInputType: TextInputType.phone,
                            
                                validator: AppValidator.forceValue,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              controller.saveOrder();
                            },
                            child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.4,
                              decoration: const BoxDecoration(
                                color: AppColors.appHallsRedDark,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: const Center(
                                child: TextWidget(
                                  AppStrings.reserve,
                                  textAlign: TextAlign.center,
                                  weight: FontWeight.bold,
                                  textColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )));
  }
}
