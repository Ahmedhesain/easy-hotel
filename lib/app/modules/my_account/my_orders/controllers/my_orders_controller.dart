



import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/orders_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/response/orders_response_dto.dart';
import 'package:easy_hotel/app/data/repository/setting/setting_repository.dart';
import 'package:get/get.dart';

class MyOrdersController extends GetxController {

  final orders = <OrdersResponse>[].obs;
  final isLoading = false.obs;




  @override
  void onInit() {
    super.onInit();
    getOrders();


  }

  getOrders() async {
    isLoading(true);
    final request = OrdersRequestDto(
        id: UserManager().user!.id!,


    );  SettingRepository().getOrders(request,
        onSuccess: (data) {
          orders.assignAll(data.data);
        },
        onError: (e) => showPopupText( e.toString()),
        onComplete: () => isLoading(false)
    );
  }
}