import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/data/model/auth/login/dto/request/login_request.dart';
import 'package:easy_hotel/app/data/model/halls/dto/response/halls_search_response_dto.dart';
import 'package:easy_hotel/app/data/repository/auth/auth_repository.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:easy_hotel/app/data/model/spa/dto/response/spa_search_response_dto.dart'
    as spa;

import '../../../core/utils/permission_handler.dart';
import '../../food/food_cart/controllers/food_cart_controller.dart';

class LoginController extends GetxController {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  final loginForm = GlobalKey<FormState>();
  final isLoading = false.obs;
  final requestDto = LoginRequestDto();
  final showPassword = false.obs;

  @override
  void onInit() async {
    await AppPermissionHandler().requestLocationPermission();
    Get.isRegistered<FoodCartController>() ? Get.find<FoodCartController>() : Get.put<FoodCartController>(FoodCartController());
    super.onInit();
  }

  Future login() async {
    if (!loginForm.currentState!.validate()) return;
    isLoading(true);
    AuthRepository().login(requestDto,
        onSuccess: (data) {
          if (data.data == null) {
            Get.offAndToNamed(Routes.REGISTER, arguments: requestDto.phone);
            return;
          }

          UserManager().login(data.data!);

          if (data.data?.hotelBooking != null) {
            UserManager().saveSelectedBranch(spa.HotelsearchModel(id: data.data?.hotelBooking));
            Get.offAndToNamed(Routes.ALLSERVICES);
             return;
          } else {
            Get.offAndToNamed(Routes.HOME);
          }
        },
        onError: (error) => showPopupText(error.toString()),
        onComplete: () => isLoading(false));
  }

  changePasswordVisibility() => showPassword(!showPassword.value);
}
