import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/model/housekeeping/dto/request/housekeeping_save_request.dart';
import 'package:easy_hotel/app/data/repository/housekeeping/housekeeping_repository.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../../data/model/housekeeping/dto/response/housekeeping_detail_response.dart';

class HouseKeepingCheckoutController extends GetxController {
  var nameController = TextEditingController(text: UserManager().user!.name ??"");
  var userNameController = TextEditingController(text:UserManager().user!.name ??"");
  var phoneController = TextEditingController(text: UserManager().user!.mobile ??"");
  var emailController = TextEditingController(text:UserManager().user!.email ??"");
  final registerForm = GlobalKey<FormState>();
  final isLoading = false.obs;
  final List res =Get.arguments;
  getHousekeepingSave() async {
    isLoading(true);
    final request = HousekeepingSaveRequest(
        branchId:res[7],
        createdBy:AppConstants.createdBy,
        companyId: AppConstants.companyId,
        customerId: UserManager().user!.id,
        houseKeepingDTOList: List<HouseKeepingDetailResponse>.from(res[0].map((e) => HouseKeepingDetailResponse(id: e))),
        dueDate: res[2],
        dueTime: res[2],
        remark: res[3],
        phone: phoneController.text,
        email: emailController.text,
        name: nameController.text,
    );
    HousekeepingRepository().getHousekeepingSave(request,
        onSuccess: (data) {
          showPopupText( AppStrings.savedSuccessfully);
          UserManager().sendNewOrderNotification(AppConstants.houseKeeping);
          Get.offAndToNamed(Routes.ALLSERVICES);


        },
        onError: (e) => showPopupText( e.toString()),
        onComplete: () => isLoading(false)
    );
  }

}
