import 'package:easy_hotel/app/components/icon_button_widget.dart';
import 'package:easy_hotel/app/components/image_widget.dart';
import 'package:easy_hotel/app/components/text_field_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/utils/common.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_assets.dart';
import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';
import 'package:easy_hotel/app/modules/my_account/my_orders/views/widgets/order_widget.dart';
import 'package:easy_hotel/app/modules/my_account/my_orders_detail/controllers/my_orders_detail_controller.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyOrdersDetailView extends GetView<MyOrdersDetailController> {
  const MyOrdersDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    const space = SizedBox(height: 20);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          // backgroundColor: AppColors.white,
          title: Column(
            children: const [
              TextWidget("تفاصيل الطلب", size: 20,),

            ],
          ),
          actions: [

            UnconstrainedBox(
              child: IconButtonWidget(
                icon:  Icons.notifications,
                onPressed: () {
                  // FavProductsManager().addProduct(controller.room!, context);
                },
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Common.getSpin(),
            );
          }
          return Container(
            // color: AppColors.white,
            width: size.width,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: SizedBox(
                      height: 250.h,
                      child: ImageWidget(
                        path: controller.orderDetail!.image ?? "",
                        fit: BoxFit.fill,
                        width: size.width,
                        radius: 0,
                      ),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const TextWidget(
                                AppStrings.services,
                                // textColor: Colors.black,
                                size: 16,
                                weight: FontWeight.w600,
                              ),
                              // for(int i =0;i<controller.res[4]!.length;i++)
                              TextWidget(
                                controller.orderDetail!.name ?? "",
                                textColor: Colors.grey,
                                size: 16,
                                weight: FontWeight.w600,
                              ),


                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timer),
                              const TextWidget(
                                AppStrings.time,
                                // textColor: Colors.black,
                                size: 16,
                                weight: FontWeight.w600,
                              ),
                              TextWidget(
                                DateFormat("yyyy-MM-dd").format(
                                    controller.orderDetail!.date ??
                                        DateTime.now())
                                ,
                                textColor: Colors.grey,
                                size: 16,
                                weight: FontWeight.w600,
                              ), TextWidget(
                                DateFormat('  hh:mm aaa').format(
                                    controller.orderDetail!.date ??
                                        DateTime.now()
                                )
                                ,
                                textColor: Colors.grey,
                                size: 16,
                                weight: FontWeight.w600,
                              ),


                            ],
                          )

                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: SizedBox(
                      width: size.width * 0.9,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,

                                children: [
                                  const TextWidget(
                                    AppStrings.additions,
                                    // textColor: Colors.black,
                                    size: 16,
                                    weight: FontWeight.w600,
                                  ),
                                  controller.orderDetail!.addtionsDTOList!
                                      .isEmpty ? const TextWidget(
                                      "لا يوجد اضافات"  ,
                                    textColor: Colors.grey,
                                    size: 16,
                                    weight: FontWeight.w600,
                                    maxLines: 3,) : Row(
                                    children: [
                                      for(int i = 0; i < controller.orderDetail!
                                          .addtionsDTOList!.length; i++)
                                        TextWidget(
                                          controller.orderDetail!
                                              .addtionsDTOList![i].name!,
                                          textColor: Colors.grey,
                                          size: 10,
                                          weight: FontWeight.w600,
                                          maxLines: 3,
                                        ),
                                      for(int i = 0; i < controller.orderDetail!
                                          .addtionsDTOList!.length; i++)
                                        TextWidget(
                                          controller.orderDetail!
                                              .addtionsDTOList![i].price!
                                              .toString(),
                                          textColor: Colors.grey,
                                          size: 10,
                                          weight: FontWeight.w600,
                                          maxLines: 3,
                                        ),
                                    ],
                                  )


                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,

                                children: [
                                  const TextWidget(
                                    "التقييم",
                                    // textColor: Colors.black,
                                    size: 16,
                                    weight: FontWeight.w600,
                                  ),
                                  controller.orderDetail!.rate==null?
                                  TextWidget(
                                    controller.orderDetail!.reviewText ??
                                        "لا يوجد",
                                    textColor: Colors.grey,
                                    size: 16,
                                    weight: FontWeight.w600,
                                    maxLines: 3,
                                  )
                                : RatingBar.builder(
                                      initialRating: controller.orderDetail!.rate!,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      ignoreGestures: true,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: AppColors.colorLogo,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      }),



                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,

                                children: [
                                  const TextWidget(
                                    "التعليق",
                                    // textColor: Colors.black,
                                    size: 16,
                                    weight: FontWeight.w600,
                                  ),
                                  TextWidget(
                                    controller.orderDetail!.reviewText ??
                                        "لا يوجد",
                                    textColor: Colors.grey,
                                    size: 16,
                                    weight: FontWeight.w600,
                                    maxLines: 3,
                                  ),


                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,

                                children: [
                                  const TextWidget(
                                    "تاريخ التقييم",
                                    // textColor: Colors.black,
                                    size: 16,
                                    weight: FontWeight.w600,
                                  ),
                                  controller.orderDetail!.reviewDate == null
                                      ? const TextWidget(
                                    "لا يوجد"
                                    ,
                                    textColor: Colors.grey,
                                    size: 16,
                                    weight: FontWeight.w600,
                                  )
                                      : TextWidget(
                                    DateFormat("yyyy-MM-dd").format(
                                        controller.orderDetail!.reviewDate!)
                                    ,
                                    textColor: Colors.grey,
                                    size: 16,
                                    weight: FontWeight.w600,
                                  )


                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,

                                children: [
                                  const TextWidget(
                                    AppStrings.totalPrice,
                                    // textColor: Colors.black,
                                    size: 16,
                                    weight: FontWeight.w600,
                                  ),
                                  TextWidget(
                                    controller.orderDetail!.cost.toString(),
                                    textColor: Colors.grey,
                                    size: 16,
                                    weight: FontWeight.w600,
                                  ),


                                ],
                              ),
                              controller.orderDetail!.rate == null ?
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Widget okButton = TextButton(
                                        child: const Center(child: TextWidget(
                                          AppStrings.confirm,
                                          textColor: Colors.white,
                                          size: 15,
                                          weight: FontWeight.bold,)),
                                        onPressed: () {
                                          controller.saveReview();

                                        },
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  title: const Center(
                                                      child: TextWidget(
                                                        "انشاء تقييم",
                                                        weight: FontWeight
                                                            .bold,)),
                                                  content: SizedBox(
                                                    height: size.height * .4,
                                                    width: size.width,

                                                    child: SingleChildScrollView(
                                                      physics: const AlwaysScrollableScrollPhysics(),
                                                      child: Column(
                                                        children: [

                                                          TextWidget(
                                                            "انشاء تقييم",
                                                            size: 20,
                                                            weight: FontWeight
                                                                .bold,),
                                                          Obx(() =>
                                                              Container(
                                                                width: size
                                                                    .width * 0.8,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        size
                                                                            .width *
                                                                            0.03),
                                                                    color: AppColors
                                                                        .appGreyLight),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .all(2.0),
                                                                  child: Center(
                                                                    child: Column(
                                                                      children: [
                                                                        RatingBar
                                                                            .builder(
                                                                          initialRating: 1,
                                                                          minRating: 1,
                                                                          direction: Axis
                                                                              .horizontal,
                                                                          allowHalfRating: false,
                                                                          itemCount: 5,
                                                                          itemSize: size
                                                                              .width *
                                                                              0.1,
                                                                          itemPadding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 0.0),
                                                                          itemBuilder: (
                                                                              context,
                                                                              _) =>
                                                                          const Icon(
                                                                            Icons
                                                                                .stars,
                                                                            color: AppColors
                                                                                .colorLogo,
                                                                          ),
                                                                          onRatingUpdate: (
                                                                              value) =>
                                                                              controller
                                                                                  .changeSelectedPersonNumber(
                                                                                  value
                                                                                      .toInt()),
                                                                        ),
                                                                        TextWidget(
                                                                          "${controller
                                                                              .selectedPersonsNumber
                                                                              .value}" +
                                                                              " نجوم",
                                                                          textColor: Colors
                                                                              .grey,
                                                                          size: 16,
                                                                          weight: FontWeight
                                                                              .w600,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )),
                                                          TextWidget(
                                                            "انشاء تعليق",
                                                            size: 20,
                                                            weight: FontWeight
                                                                .bold,),

                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .all(5.0),
                                                            child: SizedBox(
                                                              height: 100,
                                                              child: TextFieldWidget(
                                                                maxLines: 5,
                                                                controller: controller
                                                                    .comment,
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
                                                          height: size.height *
                                                              .06,
                                                          width: size.width *
                                                              .4,
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    6.00)),
                                                            color: AppColors
                                                                .appHallsRedDark,
                                                          ),
                                                          child: okButton),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: size.height * 0.04,
                                      width: size.width * 0.4,
                                      decoration: const BoxDecoration(
                                        color: AppColors.appHallsRedDark,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: const TextWidget("انشا تقييم",
                                        textAlign: TextAlign.center,
                                        weight: FontWeight.bold,
                                        textColor: AppColors.white,),
                                    ),
                                  ),
                                ),
                              )
                                  :
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Widget okButton = TextButton(
                                        child: const Center(child: TextWidget(
                                          AppStrings.confirm,
                                          textColor: Colors.white,
                                          size: 15,
                                          weight: FontWeight.bold,)),
                                        onPressed: () {
                                          controller.saveReview();
                                        },
                                      );
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return StatefulBuilder(
                                              builder: (context, setState) {
                                                return AlertDialog(
                                                  title: const Center(
                                                      child: TextWidget(
                                                        "تعديل التقييم",
                                                        weight: FontWeight
                                                            .bold,)),
                                                  content: SizedBox(
                                                    height: size.height * .4,
                                                    width: size.width,

                                                    child: SingleChildScrollView(
                                                      physics: const AlwaysScrollableScrollPhysics(),
                                                      child: Column(
                                                        children: [

                                                          TextWidget(
                                                            "تعديل التقييم",
                                                            size: 20,
                                                            weight: FontWeight
                                                                .bold,),
                                                          Obx(() =>
                                                              Container(
                                                                width: size
                                                                    .width * 0.8,
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        size
                                                                            .width *
                                                                            0.03),
                                                                    color: AppColors
                                                                        .appGreyLight),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .all(2.0),
                                                                  child: Center(
                                                                    child: Column(
                                                                      children: [
                                                                        RatingBar
                                                                            .builder(
                                                                          initialRating: 1,
                                                                          minRating: 1,
                                                                          direction: Axis
                                                                              .horizontal,
                                                                          allowHalfRating: false,
                                                                          itemCount: 5,
                                                                          itemSize: size
                                                                              .width *
                                                                              0.1,
                                                                          itemPadding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 0.0),
                                                                          itemBuilder: (
                                                                              context,
                                                                              _) =>
                                                                          const Icon(
                                                                            Icons
                                                                                .stars,
                                                                            color: AppColors
                                                                                .colorLogo,
                                                                          ),
                                                                          onRatingUpdate: (
                                                                              value) =>
                                                                              controller
                                                                                  .changeSelectedPersonNumber(
                                                                                  value
                                                                                      .toInt()),
                                                                        ),
                                                                        TextWidget(
                                                                          "${controller
                                                                              .selectedPersonsNumber
                                                                              .value}" +
                                                                              " نجوم",
                                                                          textColor: Colors
                                                                              .grey,
                                                                          size: 16,
                                                                          weight: FontWeight
                                                                              .w600,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )),
                                                          TextWidget(
                                                            "تعديل التعليق",
                                                            size: 20,
                                                            weight: FontWeight
                                                                .bold,),

                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .all(5.0),
                                                            child: SizedBox(
                                                              height: 100,
                                                              child: TextFieldWidget(
                                                                maxLines: 5,
                                                                controller: controller
                                                                    .comment,
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
                                                          height: size.height *
                                                              .06,
                                                          width: size.width *
                                                              .4,
                                                          decoration: const BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    6.00)),
                                                            color: AppColors
                                                                .appHallsRedDark,
                                                          ),
                                                          child: okButton),
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                      );
                                    },
                                    child: Container(
                                      height: size.height * 0.04,
                                      width: size.width * 0.4,
                                      decoration: const BoxDecoration(
                                        color: AppColors.appHallsRedDark,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      child: const TextWidget("تعديل تقييم",
                                        textAlign: TextAlign.center,
                                        weight: FontWeight.bold,
                                        textColor: AppColors.white,),
                                    ),
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0,10,0,10),
                  //   child: Center(
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         controller.getRoomSave();
                  //       },
                  //       child: Container(
                  //         height: size.height * 0.05,
                  //         width: size.width * 0.4,
                  //         decoration: const BoxDecoration(
                  //           color: AppColors.appHallsRedDark,
                  //           borderRadius:
                  //           BorderRadius.all(Radius.circular(5)),
                  //         ),
                  //         child: const TextWidget(
                  //           AppStrings.reserve,
                  //           textAlign: TextAlign.center,
                  //           weight: FontWeight.bold,
                  //           textColor: Colors.white,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )


                ],
              ),
            ),
          );
        })
    );
  }
}