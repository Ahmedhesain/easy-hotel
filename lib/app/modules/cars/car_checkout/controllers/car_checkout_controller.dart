import 'package:easy_hotel/app/core/extensions/string_ext.dart';
import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/model/cars/dto/request/cars_order_request.dart';
import 'package:easy_hotel/app/data/model/housekeeping/dto/request/housekeeping_save_request.dart';
import 'package:easy_hotel/app/data/repository/cars/cars_repository.dart';
import 'package:easy_hotel/app/data/repository/housekeeping/housekeeping_repository.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/user/dto/request/send_fcm_request.dart';
import '../../../../data/repository/user/user_repository.dart';

class CarCheckoutController extends GetxController {
  var nameController = TextEditingController(text: UserManager().user!.name ??"");
  var userNameController = TextEditingController(text:UserManager().user!.name ??"");
  var phoneController = TextEditingController(text: UserManager().user?.mobile ?? UserManager().user?.phone   ?? "");
  var emailController = TextEditingController(text:UserManager().user!.email ??"");
  var passwordController = TextEditingController();
  final registerForm = GlobalKey<FormState>();
  final loading = false.obs;
  final List res =Get.arguments;
  saveOrder() {
    if(!(registerForm.currentState?.validate() ?? true)){showPopupText(AppStrings.required);return;} 
    loading(true);
    final request = CarsOrderRequest(
        carId: res[0].id!,
        carName: res[0].name,
        groupId: res[0].groupId,
        groupName: res[0].groupName,
        dueDate: res[1],
        createdBy: AppConstants.createdBy,
        // dueTime:  DateTime.parse("0000-00-00T${res[2].toString().trim()}:00Z"),
        isGoingAndRetrun: res[3],
        personNumber: res[4],
        trafficId: res[5].id!,
        customerId: UserManager().user!.id!,
        branchId: res[0].branchId!,
        companyId: AppConstants.companyId,
        remark: res[6],
        phone: phoneController.text,
        email: emailController.text,
        name: nameController.text,
        customerName: UserManager().user!.name,
        dueTime: res[2].toString().dateFromTimeString(res[1]),
      // datet:  DateTime.parse("0000-00-00T${res[2].toString().trim()}:00Z")
    );
    CarsRepository().saveCarsOrder(request,
        onError: (e) => showPopupText(e), onComplete: () => loading(false), onSuccess: (data) {
          showPopupText(AppStrings.savedSuccessfully);
          UserManager().sendNewOrderNotification(AppConstants.cars);
          Get.toNamed(Routes.ALLSERVICES);
        } );
  }
}
