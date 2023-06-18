import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/model/housekeeping/dto/request/housekeeping_save_request.dart';
import 'package:easy_hotel/app/data/model/polman/dto/request/polman_save_request.dart';
import 'package:easy_hotel/app/data/repository/housekeeping/housekeeping_repository.dart';
import 'package:easy_hotel/app/data/repository/polman/polman_repository.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PolmanCheckoutController extends GetxController {
  var nameController = TextEditingController(text: UserManager().user!.name ??"");
  var userNameController = TextEditingController(text:UserManager().user!.name ??"");
  var phoneController = TextEditingController(text: UserManager().user!.mobile ?? UserManager().user!.phone ??"");
  var emailController = TextEditingController(text:UserManager().user!.email ??"");


  final registerForm = GlobalKey<FormState>();
  final List res =Get.arguments;
  final isLoading = false.obs;

  getpolmanSave() async {
    isLoading(true);
    final request = PolmanSaveRequest(
        remark: res[0],
        // serviceTypeId:res[1] ,
        branchId: UserManager().selectedBranch!.id!,
        createdBy:AppConstants.createdBy,
        companyId: AppConstants.companyId,
        customerId: UserManager().user!.id,
        dueTime: res[2],
        dueDate: res[2],
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text
    );
    PolmanRepository().getPolmanSave(request,
        onSuccess: (data) {
          showPopupText(AppStrings.savedSuccessfully);
          UserManager().sendNewOrderNotification(AppConstants.polman);
          Get.toNamed(Routes.ALLSERVICES);
        },
        onError: (e) => showPopupText( e.toString()),
        onComplete: () => isLoading(false)
    );
  }
  // getpolmanSaveNow() async {
  //   isLoading(true);
  //   final request = PolmanSaveRequest(
  //       remark: remark.text,
  //       serviceTypeId:res[1] ,
  //       branchId: UserManager().selectedBranch!.id!,
  //       createdBy:AppConstants.createdBy,
  //       companyId: AppConstants.companyId,
  //       customerId: UserManager().user!.id,
  //       time: DateTime.now()
  //   );
  //   PolmanRepository().getPolmanSave(request,
  //       onSuccess: (data) {
  //         showPopupText( "تم الحفظ بنجاح");
  //         Get.toNamed(Routes.ALLSERVICES);
  //       },
  //       onError: (e) => showPopupText( e.toString()),
  //       onComplete: () => isLoading(false)
  //   );
  // }

}
