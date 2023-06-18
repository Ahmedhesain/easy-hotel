
import 'package:easy_hotel/app/components/image_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';
import 'package:easy_hotel/app/modules/my_account/my_orders/controllers/my_orders_controller.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class OrderWidget extends GetView<MyOrdersController> {
  const OrderWidget({ this.statue , this.id,this.appId,this.branchId,this.itemId,this.reviewId,this.price, this.image, this.title, this.subtitle, this.rate, this.cancel , Key? key}) : super(key: key);
  final int ?id;
  final int ?appId;
  final int ?branchId;
  final int ?itemId;
  final int ?reviewId;
  final num ?price;
  final String? image;
  final String? title ;
  final String? subtitle ;
    final String? statue ;
  final double ? rate ;
  final num ? cancel ;



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;


    return GestureDetector(onTap: (){
      Get.toNamed(Routes.MY_ORDERS_DETAIL,arguments: [id,appId,branchId,itemId,reviewId] );    },
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.fromLTRB(size.width*.025, size.height*.01, size.width*.025, size.height*.005),
            child: Container(
              height: size.height*.2,
              width: size.width,
              decoration:const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)),
                color: AppColors.appGreyDark,
              ),
              child:Row(
                  children: [
                   ImageWidget(
                            path: ApiProvider.imageUrl + (image ?? ""),
                            height:  size.height * 0.2,
                            width: size.width * 0.25,
                            fit: BoxFit.cover,
                          )
                      ,
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(width: size.width*.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:   [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(title!,textColor: Colors.black,size: 20,weight: FontWeight.bold),
                               cancel == 1 ?  GestureDetector(
                            onTap: (){
                              controller.cancle(id , appId);
                            },
                                  child: Container(alignment: Alignment.center,
                                    height: size.height*.04,
                                    width: size.width*.22,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all( Radius.circular(20.00)),color: AppColors.appHallsRedDark,
                                    ),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                          child: Center(child: TextWidget(AppStrings.cancelorder,weight: FontWeight.bold,textColor: Colors.white,)),
                                        ),
                                      ],
                                    ),

                                  ),
                                ) : const SizedBox(),
                              ],
                            ),
                            TextWidget(subtitle!, textColor: Colors.grey,size: 12,weight: FontWeight.bold,),
                            TextWidget(price.toString()+AppStrings.LE,textColor: Colors.grey,size: 10,weight: FontWeight.bold,),
                            TextWidget(statue ?? "",textColor: Colors.grey,size: 10,weight: FontWeight.bold,),
                            Expanded(
                              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  rate == 0 ? const TextWidget("اضف تقييم",size: 15,weight: FontWeight.bold,):
                                  RatingBar.builder(
                                      initialRating: rate??0,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      ignoreGestures: true,
                                      itemPadding:const  EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: AppColors.colorLogo,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      }),

                                  GestureDetector(
                                    child: Container(alignment: Alignment.center,
                                      height: size.height*.04,
                                      width: size.width*.22,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all( Radius.circular(20.00)),color: AppColors.appHallsRedDark,
                                      ),
                                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: const[
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                            child: Center(child: TextWidget(AppStrings.information,weight: FontWeight.bold,textColor: Colors.white,)),
                                          ),
                                        ],
                                      ),

                                    ),
                                  ),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ]
              ),
            ),
          ),
        ],
      ),
    );


  }
}
