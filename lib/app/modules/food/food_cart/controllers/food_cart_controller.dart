import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:get/get.dart';
import '../../../../core/utils/res_cart_manager.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../data/model/restaurant/dto/response/item_response.dart';
import '../../../../data/model/restaurant/dto/sales_details_model.dart';
import '../../../../data/model/restaurant/dto/sales_model.dart';
import '../../../../data/repository/restaurant/restaurant_repository.dart';
import '../../../../routes/app_pages.dart';

class FoodCartController extends GetxController {
  final cartList = <ItemResponse>[].obs;
  final totalPrice = 0.0.obs;
  final user = UserManager();
  final isLoading = false.obs;
  @override
  onInit() {
    super.onInit();
    RestaurantCartManager().getCartList();
    cartList.assignAll(RestaurantCartManager().cartList);
    calcTotalPrice();
  }

  calcTotalPrice(){
   totalPrice(0);
   for(var pro in cartList){
    totalPrice.value+= (pro.sumPrice ?? pro.price ?? 0.0).toDouble() ;
   }
   totalPrice.refresh();
  }
  add(ItemResponse item) { 
    cartList.add(item);
    RestaurantCartManager().addToCart(item);
    cartList.refresh();
    calcTotalPrice();
  }

  remove(int index) {
    cartList.removeAt(index);
    RestaurantCartManager().removeFromCart(index);
    calcTotalPrice();
  }

  removeAll() {
    cartList.clear();
    RestaurantCartManager().removeAllFromCart();
    calcTotalPrice();
  }
  

  
  
}
