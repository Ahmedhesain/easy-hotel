import 'package:easy_hotel/app/core/extensions/string_ext.dart';
import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/model/housekeeping/dto/request/housekeeping_save_request.dart';
import 'package:easy_hotel/app/data/model/spa/dto/request/spa_save_request.dart';
import 'package:easy_hotel/app/data/repository/housekeeping/housekeeping_repository.dart';
import 'package:easy_hotel/app/data/repository/spa/spa_repository.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class SpaCheckoutController extends GetxController {
  var nameController =
      TextEditingController(text: UserManager().user!.name ?? "");
  var userNameController =
      TextEditingController(text: UserManager().user!.name ?? "");
  var phoneController = TextEditingController(
      text: UserManager().user!.mobile ?? UserManager().user!.phone ?? "");
  var remarkController = TextEditingController();
  var emailController =
      TextEditingController(text: UserManager().user!.email ?? "");
  final isLoading = false.obs;
  final totalPrice = 0.0.obs;

  final registerForm = GlobalKey<FormState>();
  final List res = Get.arguments;

  getSpaSave() async {
    if (res[1].toList().isEmpty) {
      showPopupText("يجب اختيار خدمة");
      return;
    }
    isLoading(true);
    final request = SpaSaveRequest(
        spaId: res[0],
        // spaItemDTOList: res[1].toList(),
        salesDetailSpaItemDTOList: [],
        companyId: AppConstants.companyId,
        createdBy: AppConstants.createdBy,
        customerId: UserManager().user!.id,
        branchId: res[2] ?? 232,
        phone: phoneController.text,
        remarks: remarkController.text,
        email: emailController.text,
        name: nameController.text,
        dueDate: res[11].toString().isNotEmpty
            ? res[11].toString().dateFromTimeString(res[10])
            : res[10],
        dueTime: res[11].toString().isNotEmpty
            ? res[11].toString().dateFromTimeString(res[10])
            : res[10],
        salesSpaList: res[9]);
    SpaRepository().getSpaSave(request,
        onSuccess: (data) {
          showPopupText(AppStrings.savedSuccessfully);
          UserManager().sendNewOrderNotification(AppConstants.spa);
          Get.toNamed(Routes.ALLSERVICES);
          // res[1]([]);
        },
        onError: (e) => showPopupText(e.toString()),
        onComplete: () => isLoading(false));
  }
}
