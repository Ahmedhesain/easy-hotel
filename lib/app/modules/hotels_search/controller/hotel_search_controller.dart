

import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/data/model/user/dto/request/get_hotel_for_service_request.dart';
import 'package:easy_hotel/app/data/repository/hotel_search_for_services/hotel_search_for_services_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/spa/dto/response/spa_search_response_dto.dart';
import '../../../data/model/spa/dto/request/spa_search_request_dto.dart';
import '../../food/food_cart/controllers/food_cart_controller.dart';

class HotelSearchController extends GetxController {

  final searchFocusNode = FocusNode().obs;
  final searchController = TextEditingController().obs;
  final homeSearchController = TextEditingController().obs;
  final hotelsList = <HotelsearchModel>[].obs;
  final customerHotelsList = <HotelsearchModel>[].obs;
  final loading = false.obs ;
  @override
  onInit(){
        Get.isRegistered<FoodCartController>() ? Get.find<FoodCartController>() : Get.put<FoodCartController>(FoodCartController());
    getCustomerHotel();
    getUserHotel();
    super.onInit();

  }

  requestFocus(){
    searchFocusNode.value.requestFocus();
  }

  getUserHotel(){
    final request = GetHotelForServicesRequest(invOrganizationId:  UserManager().user!.id!);
    HotelSearchForServicesRepository().getHotelForServicesByCustomerId(
      request,
      onSuccess: (data)async{
        if(data.data!.id != null){
         await UserManager().saveSelectedBranch(data.data!);
        }
      },
      onComplete: (){
        if(UserManager().selectedBranch != null){
          searchController.value.text = UserManager().selectedBranch!.nameAr! ;
          homeSearchController.value.text = UserManager().selectedBranch!.nameAr! ;
          searchHotelForServices();
        }
      },
      onError: (e) => showPopupText(e),
    );
  }
  getCustomerHotel(){
    loading(true);
    final request = GetHotelForServicesRequest(customerId:  UserManager().user!.id!);
    HotelSearchForServicesRepository().getHotelListForServicesByCustomerId(
      request,
      onSuccess: (data)=> customerHotelsList.assignAll(data.data ?? []),
      onComplete: ()=> loading(false),
      onError: (e) => showPopupText(e),
    );
  }
 Future searchHotelForServices() async{
    if(searchController.value.text.tr.isEmpty){
      hotelsList.value = [] ;
      return ;
    }
    final request = SpaSearchRequest(name: searchController.value.text);
  await  HotelSearchForServicesRepository().searchHotelForServices(
        request,
       onSuccess: (data){
         hotelsList.value = [] ;
         hotelsList.assignAll(data.data);
       },
      onError: (e) => showPopupText(e),
    );
  }

  @override
  void onReady() {
    requestFocus();
    super.onReady();
  }


}