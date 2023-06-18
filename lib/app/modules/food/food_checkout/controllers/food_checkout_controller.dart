import 'package:easy_hotel/app/core/extensions/string_ext.dart';
import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_constants.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/model/cars/dto/request/cars_order_request.dart';
import 'package:easy_hotel/app/data/model/housekeeping/dto/request/housekeeping_save_request.dart';
import 'package:easy_hotel/app/data/repository/cars/cars_repository.dart';
import 'package:easy_hotel/app/data/repository/housekeeping/housekeeping_repository.dart';
import 'package:easy_hotel/app/data/repository/rooms/rooms_repository.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/res_cart_manager.dart';
import '../../../../data/model/restaurant/dto/response/item_response.dart';
import '../../../../data/model/restaurant/dto/sales_details_model.dart';
import '../../../../data/model/restaurant/dto/sales_model.dart';
import '../../../../data/model/rooms/dto/request/customer_room_request.dart';
import '../../../../data/model/rooms/dto/request/room_request_by_number.dart';
import '../../../../data/model/user/dto/request/hotel_places_request.dart';
import '../../../../data/model/user/dto/response/delivery_place_response.dart';
import '../../../../data/repository/hotel_search_for_services/hotel_search_for_services_repository.dart';
import '../../../../data/repository/restaurant/restaurant_repository.dart';
import '../../../../data/repository/user/user_repository.dart';
import '../../food_cart/controllers/food_cart_controller.dart';

class FoodCheckoutController extends GetxController {
  final user = UserManager();
  var nameController =
      TextEditingController(text: UserManager().user!.name ?? "");
  var userNameController =
      TextEditingController(text: UserManager().user!.name ?? "");
  var phoneController = TextEditingController(
      text: UserManager().user?.mobile ?? UserManager().user?.phone ?? "");
  var emailController =
      TextEditingController(text: UserManager().user!.email ?? "");
  var passwordController = TextEditingController();
  var remark = TextEditingController();
  var deliveryPlaceController = TextEditingController();

  final registerForm = GlobalKey<FormState>();
  final loading = false.obs;
  final List<ItemResponse> cartList = Get.arguments;
  final palcesList = <DeliveryPlaceResponse>[].obs;

  Rxn<DeliveryPlaceResponse> selectedPlace = Rxn();

  final sumPrice = 0.0.obs;
  final deliveryPlace = 0.obs;
  final roomNumber = 0.obs;
  final roomId = 0.obs;

  @override
  void onInit() async {
    await getRoomNumber();
    await getHotelPlaces();
    for (var element in cartList) {
      sumPrice(sumPrice.value + (element.sumPrice ?? 0));
    }
    super.onInit();
  }

  Future getRoomNumber() async {
    loading(true);
    final request = CustomerRoomRequest(
        id: user.user!.id!, branchId: user.selectedBranch!.id!);
    await UserRepository().getRoomNumberByCustomerId(request,
        onComplete: () => loading(false),
        onError: (e) => showPopupText(AppStrings.serverError),
        onSuccess: (data) {
          if (data.data != null) {
            roomNumber(data.data);
            deliveryPlaceController.text = roomNumber.value.toString();
          }
        });
  }

  Future getHotelPlaces() async {
    loading(true);
    final request = HotelPalcesRequest(user.selectedBranch!.id!);
    await HotelSearchForServicesRepository().hotelPlaces(request,
        onComplete: () => loading(false),
        onError: (e) => showPopupText(AppStrings.serverError),
        onSuccess: (data) => palcesList.assignAll(data.data));
  }

  Future getRoomId() async {
    loading(true);
    final request = RoomRequestByNumber(
        serial: int.tryParse(deliveryPlaceController.text) ?? -1,
        branchId: user.selectedBranch!.id!);
    await RoomsRepository().getRoomByRoomNumber(request,
        onComplete: () => loading(false),
        onError: (e) => showPopupText(AppStrings.noRoomsFound),
        onSuccess: (data) {
          roomId(data.data?.id ?? -1);
          data.data?.id == null ? deliveryPlaceController.clear() : null;
        });
  }

  Future saveOrder() async {
    if (deliveryPlaceController.text.isEmpty) {
      showPopupText(AppStrings.shouldSelectDelveryPlace.tr);
      return;
    }
    if (cartList.isEmpty) {
      return;
    }
    loading(true);
    final request = Sales();
    request.salesDetialList = [];
    request.salesDetialListDeleted = [];
    request.deliveryPlace = selectedPlace.value?.id; // مكان الاستلام
    request.currencySerial = user.selectedBranch?.currencyId ?? 73; //
    request.gallaryName = "test";
    request.invoiceDate = DateTime.now();
    // request.takeDate = DateTime.;
    // request.offerId ;
    request.remarks = "";
    // request.tax ;
    request.branchId = user.selectedBranch?.id;
    request.companyId = 74;
    request.createdBy = 354;
    request.customerId = user.user?.id;
    request.address = user.user?.address;
    request.customerName = user.user?.name;
    request.customerMobile =
        user.user != null ? user.user?.phone ?? (user.user?.mobile ?? "") : "";
    request.createdDate = DateTime.now();
    request.typeSave = 0;
    request.tableNumber = deliveryPlace.value == 1
        ? int.tryParse(deliveryPlaceController.text)
        : null;
    request.orderType = 0;
    request.roomId = roomId.value != -1 ? roomId.value : null;
    request.isOpen = 0;
    request.startDate = cartList.last.requiredDate ??
        DateTime(
            request.createdDate!.year,
            request.createdDate!.month,
            request.createdDate!.hour,
            (request.createdDate!.minute + (cartList.last.time ?? 0)).toInt());
    request.createdByName = user.user?.name;
    for (ItemResponse product in cartList) {
      SalesDetails details = fromProductToSalesDetails(product);
      request.salesDetialList!.add(details);
    }

    await RestaurantRepository().saveOrder(request,
        onComplete: () => loading(false),
        onError: (e) => showPopupText(AppStrings.serverError),
        onSuccess: (_) {
          removeAll();
          showPopupText(AppStrings.savedSuccessfully);
          UserManager().sendNewOrderNotification(AppConstants.food);
          Get.offAndToNamed(Routes.ALLSERVICES);
        });
  }

  SalesDetails fromProductToSalesDetails(ItemResponse product) {
    SalesDetails details = SalesDetails();
    details.id = product.oldDetailId;
    // details.s = product.serial.toString();
    details.price = product.salePrice ?? product.price;
    details.quantity = double.parse(product.quantity!.toString());
    details.name = product.selectedVariation != null
        ? "${product.name!}-${product.selectedVariation!.variationDetailsName!}"
        : product.name;
    details.groupId = product.groupId;
    details.net = details.price! * details.quantity!;
    details.resItemVariation = product.selectedVariation != null
        ? product.selectedVariation!.id
        : null;
    details.itemId = product.id;
    details.resSalesDetailsAdditionsDTOList = [];
    details.appId = product.appId;
    details.remark = product.remark;
    details.createdDate = DateTime.now();
    details.createdBy = 354;
    details.startDate = product.requiredDate ??
        DateTime(
            details.createdDate!.year,
            details.createdDate!.month,
            details.createdDate!.hour,
            (details.createdDate!.minute + (product.time ?? 0)).toInt());
    if (product.addititonsList != null) {
      for (int i = 0; i < product.addititonsList!.length; i++) {
        if ((product.addititonsList?[i].selected ?? false) == true) {
          details.additionsList!.add(product.addititonsList![i]);
        }
      }
    }
    return details;
  }

  removeAll() {
    cartList.clear();
    Get.find<FoodCartController>().cartList.clear();
    Get.find<FoodCartController>().removeAll();
    RestaurantCartManager().removeAllFromCart();
  }
}
