
import 'package:easy_hotel/app/components/icon_button_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';
import 'package:easy_hotel/app/modules/my_account/acoount_homepage/views/widgets/setting_tab_widget.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../components/bottom_nav_bar.dart';

class MyAccountView extends GetView<MyAccountView> {
  const MyAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var  space= Container(height: 2,width: size.width,color: AppColors.appGreyDark,);

    return Scaffold(
            // bottomNavigationBar: const AppBottomNavBar(index: 5),
      appBar: AppBar(
        elevation: 0,
        leading:
        GestureDetector(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title:
        const TextWidget(
          AppStrings.myProfile, weight: FontWeight.bold, size: 25,),
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
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              const Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundImage: NetworkImage("${ApiProvider.imageUrl}image"),
                  radius: 33.00,
                ),
              ),
              TextWidget(UserManager().user?.name??"",weight: FontWeight.bold , size: 15,),
              space,
              const TextWidget(AppStrings.mange,weight: FontWeight.bold , size: 20,),
              GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.SETTINGS);
                  },
                  child: const SettingTabWidget(Icons.settings,AppStrings.setting,)),
              space,
              GestureDetector(onTap: (){
                Get.toNamed(Routes.MANGE_ACCOUNT);
              },child: const SettingTabWidget(Icons.account_circle,AppStrings.mange)),
              space,
              GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.CHANGE_PASSWORD);
                  },
                  child: const SettingTabWidget(Icons.password,AppStrings.changePassword)),
              space,
              GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.CHANGE_EMAIL);
                  },
                  child: const SettingTabWidget(Icons.rate_review,AppStrings.changeEmail)),
              space,
              const SettingTabWidget(Icons.book,AppStrings.terms),
              space,
              GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.MY_ORDERS);
                  },
                  child: const SettingTabWidget(Icons.star_border,AppStrings.ordesr)),
              space,
              GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.FAV_PRODUCTS);
                  },
                  child: const SettingTabWidget(Icons.favorite_border,AppStrings.liked)),
              space,
              GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.CONTACT_US);
                  },
                  child: const SettingTabWidget(Icons.contact_support,AppStrings.contactUs)),
              space,
              GestureDetector(
                  onTap: (){
                    UserManager().logout();
                  },
                  child: const SettingTabWidget(Icons.logout,AppStrings.logout)),







            ],
          ),
        ),
      )
      ,
    );

  }
}
