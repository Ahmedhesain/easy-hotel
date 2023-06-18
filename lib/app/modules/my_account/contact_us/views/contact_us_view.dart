import 'package:easy_hotel/app/components/bottom_nav_bar.dart';
import 'package:easy_hotel/app/components/button_widget.dart';
import 'package:easy_hotel/app/components/icon_button_widget.dart';
import 'package:easy_hotel/app/components/text_field_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/utils/common.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/utils/validator.dart';
import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';
import 'package:easy_hotel/app/modules/my_account/change_password/controllers/change_password_controller.dart';
import 'package:easy_hotel/app/modules/my_account/contact_us/controllers/contact_us_controller.dart';
import 'package:easy_hotel/app/modules/my_account/mange_account/controllers/mange_account_controller.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    const space = SizedBox(height: 20);
    return Scaffold(
      bottomNavigationBar: const AppBottomNavBar(index: 4),
      appBar: AppBar(
        elevation: 0,
        leading:
        GestureDetector(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const TextWidget(AppStrings.contactUs),

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
        ],      ),
      body: Obx(() {
        if (controller.loading.value) {
          return Center(
            child: Common.getSpin(),
          );
        }
        return Container(
          margin: const EdgeInsets.all(10),
          height: size.height,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Form(
              key: controller.registerForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const TextWidget(
                  //   AppStrings.contactUs, size: 20, weight: FontWeight.bold,
                  // ),
                  // space,

                  TextFieldWidget(
                    controller: controller.subjectController,
                    hint:AppStrings.subject ,
                    suffixIcon: Icons.pin,
                    textInputAction: TextInputAction.next,
                    // onChange: (value) => controller.requestDto.name = value,

                    validator: AppValidator.forceValue,
                  ),
                  space,
                  TextFieldWidget(
                    controller: controller.messageController,
                    hint: AppStrings.message,
                    maxLines: 8,
                    maxLength: 1000,
                    multiLines: true,
                    suffixIcon: Icons.pin,
                    textInputAction: TextInputAction.next,
                    // onChange: (value) => controller.requestDto.name = value,

                    validator: AppValidator.forceValue,
                  ),space,
                  // TextWidget(AppStrings.email,size: 15,weight: FontWeight.bold,),
                  // TextWidget(UserManager().user?.email ?? "",size: 20,weight: FontWeight.bold,),




                  space,
                  ButtonWidget(
                    text: AppStrings.send,
                    onPressed:() => controller.sendMessage(),
                    expanded: true,
                    fontColor: Colors.white,
                    fontSize: size.height * .026,
                    buttonColor: AppColors.appHallsRedDark,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  // GestureDetector(
                  //   onTap:() {controller.launchWhatsApp;},
                  //
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.question_answer),
                  //       GestureDetector(
                  //         onTap:() {controller.launchWhatsApp();},
                  //         child:Center(child: TextWidget('واتساب +001-(555)1234567',size: 20,weight: FontWeight.bold,)),
                  //       ),
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                  // GestureDetector(
                  //   onTap:() {launch("tel://21213123123");},
                  //
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.phone),
                  //
                  //       GestureDetector(
                  //         onTap:() {launch("tel://21213123123");},
                  //         child:Center(child: TextWidget('الاتصال 21213123123',size: 20,weight: FontWeight.bold,)),
                  //       ),
                  //
                  //     ],
                  //   ),
                  // )

                ],
              ),
            ),
          ),
        );
      })

      ,
    );
  }
}
