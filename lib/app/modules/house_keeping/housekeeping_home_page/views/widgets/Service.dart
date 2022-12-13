import 'package:easy_hotel/app/components/image_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_home_page/controllers/house_keeping_controller.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class HousekeepingServicesWidget extends GetView<HouseKeepingController> {
  const HousekeepingServicesWidget(this.image, this.name, this.id, this.index,  {Key? key}) : super(key: key);
  final String image;
  final String name;
  final int id;
  final int index;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(onTap: (){
      Get.toNamed(Routes.HOUSEKEEPING_SERVICES,arguments:id,);
    },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.00)),
          border:  Border.all(color: AppColors.appGreyDark,width: 2),
          color: Colors.blueAccent,
        ),
        child: Column(
          children: [
            ImageWidget(path: image
              ,fit: BoxFit.cover,),
            TextWidget(name, textAlign: TextAlign.center,weight:FontWeight.bold,size: 20,textColor: Colors.white,)
          ],
        ),
      ),
    );
  }
}
