import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/data/model/restaurant/dto/response/item_response.dart';
import 'package:easy_hotel/app/modules/food/food_cart/controllers/food_cart_controller.dart';
import 'package:get/get.dart';

import '../../../core/utils/res_cart_manager.dart';
import '../../../data/model/restaurant/dto/request/group_request.dart';
import '../../../data/model/restaurant/dto/request/offers_request.dart';
import '../../../data/model/restaurant/dto/request/slider_request.dart';
import '../../../data/model/restaurant/dto/response/group_response.dart';
import '../../../data/model/restaurant/dto/response/item_mini_response.dart';
import '../../../data/model/restaurant/dto/response/slider_response.dart';
import '../../../data/repository/restaurant/restaurant_repository.dart';

class RestaurantController extends GetxController {

  final sliderList = <SlidersResponse>[].obs;
  final offerList = <ItemMiniResponse>[].obs;
  final groupList = <GroupResponse>[].obs;
  final loading = false.obs ;
  final offerLoading = false.obs ;
  final groupLoading = false.obs ;
  final cartLength = 0.obs ;


  
  @override
  void onInit() async{
    Get.isRegistered<FoodCartController>() ? Get.find<FoodCartController>() : Get.put<FoodCartController>(FoodCartController());
    getSliders();
    getOfferList();
    getGroupList();
    super.onInit();
  }


  getSliders(){
    loading(true);
    final request = SlidersRequest(
      branchId: UserManager().selectedBranch!.id! ,
      appId: 1 ,
      pageId: 271,
      positionNumber: 0
    );
    RestaurantRepository().getSliders(
        request,
      onComplete: () => loading(false),
      onError: (e) => showPopupText(e),
      onSuccess: (data) => sliderList.assignAll(data.data)
    );
    
  }

  getOfferList(){
    offerLoading(true);
    final request = OffersRequest(
        appId: 1 ,
        branchId: UserManager().selectedBranch!.id!,
        currencySerial: 1
    );
    RestaurantRepository().getOfferList(
        request,
        onComplete: () => offerLoading(false),
        onError: (e) => showPopupText(e),
        onSuccess: (data) => offerList.assignAll(data.data)
    );
  }

  getGroupList(){
    groupLoading(true);
    final request = GroupRequest(
        appId: 1 ,
        branchId:UserManager().selectedBranch!.id!,
    );
    RestaurantRepository().getGroupList(
        request,
        onComplete: () => groupLoading(false),
        onError: (e) => showPopupText(e),
        onSuccess: (data) => groupList.assignAll(data.data)
    );
  }




}
