
import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_assets.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/model/app_services/dto/request/application_request.dart';
import 'package:easy_hotel/app/data/model/app_services/dto/response/application_response_dto.dart';
import 'package:easy_hotel/app/data/model/spa/dto/response/spa_search_response_dto.dart';
import 'package:easy_hotel/app/data/repository/hotel_search_for_services/hotel_search_for_services_repository.dart';
import 'package:easy_hotel/app/modules/allServices/services_model.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../data/model/user/dto/request/get_hotel_for_service_request.dart';
import '../../food/food_cart/controllers/food_cart_controller.dart';

class AllServicesController extends GetxController {
  final appServicesList = <ApplicationResponse>[].obs;

  final isLoading = true.obs;
  @override
  void onInit() {
    Get.isRegistered<FoodCartController>() ? Get.find<FoodCartController>() : Get.put<FoodCartController>(FoodCartController());
    getAppServices();
    super.onInit();
  }



  getAppServices(){
    final request = ApplicationRequest(
        id: UserManager().selectedBranch!.id!);
    HotelSearchForServicesRepository().appServices(
      request,
      onSuccess: (data)async{
        appServicesList.assignAll(data.data ?? []);
      },
      onComplete: ()=>isLoading(false),
      onError: (e) => showPopupText(e),
    );
  }


//   List<ServiceModel> allServices=[
//   ServiceModel(name: AppStrings.spaService, image:hotel!.imgSpa, pageRoute: Routes.SPADETAILS),
//   ServiceModel(name: AppStrings.foodService, image: hotel!.imgFood, pageRoute: Routes.RESTURANT),
//   ServiceModel(name: AppStrings.hallsService, image: hotel!.imgHole, pageRoute: Routes.HALLS),
//   ServiceModel(name: AppStrings.housekeepingService, image: hotel!.imgHouseKeeping, pageRoute: Routes.HOUSE_KEEPING),
//   ServiceModel(name: AppStrings.roomsService, image: hotel!.imgRoom, pageRoute: Routes.ROOMS),
//   ServiceModel(name: AppStrings.polmanService, image: hotel!.imgPolman, pageRoute: Routes.POLMAN),
//   ServiceModel(name: AppStrings.carsServices, image: hotel!.imgCar  , pageRoute: Routes.CARS)
// ];
}
