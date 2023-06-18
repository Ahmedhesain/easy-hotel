import 'dart:convert';
import 'package:easy_hotel/app/core/utils/show_popup_text.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/repository/restaurant/restaurant_repository.dart';
import 'package:get/get.dart';
import '../../../../core/utils/res_cart_manager.dart';
import '../../../../core/utils/restaurant_strorage.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../data/model/restaurant/dto/request/group_items_request.dart';
import '../../../../data/model/restaurant/dto/request/item_request.dart';
import '../../../../data/model/restaurant/dto/response/attribute_details_model.dart';
import '../../../../data/model/restaurant/dto/response/attribute_model.dart';
import '../../../../data/model/restaurant/dto/response/item_mini_response.dart';
import '../../../../data/model/restaurant/dto/response/item_response.dart';
import '../../../../data/model/restaurant/dto/response/variation_model.dart';

class FoodItemController extends GetxController {
  final user = UserManager();
  final count = 1.obs;
  final itemId = Get.arguments ;
  final loading = false.obs ;
  Rxn<Variation> selectedVariation = Rxn();
  Rxn<ItemResponse> pro = Rxn();
  final attributeList = <Attribute>[].obs;
  final timeSelected = DateTime.now().obs ;
  void increment(){
    count.value++;
    pro.value?.quantity =count.value;
    calcAddPrice();
  } 
  void decrement(){
    count.value>1?count.value--:null;
    pro.value?.quantity =count.value;
    calcAddPrice();
  } 
  final selectedAdditions = <Additions>[].obs ;
  final groupItems = <ItemMiniResponse>[].obs ;


  @override
  void onInit() async{
   await getItem();
   await getGroupItems();
    super.onInit();
  }

  getGroupItems(){
    loading(true);
    final request = GroupItemsRequest(groupId:pro.value?.groupId ?? 393 , currencySerial: 1);
    RestaurantRepository().getGroupItemsList(request ,
        onSuccess: (data) => groupItems.assignAll(data.data ?? []),
        onError: (e)=> showPopupText(e),
        onComplete: ()=> loading(false)
    );
  }

  changeAddition(Additions selected){
    if(selectedAdditions.contains(selected)){
      selectedAdditions.remove(selected);
    }else{
      selectedAdditions.add(selected);
    }
    calcAddPrice();
  }

  calcAddPrice(){
    pro.value!.sumPrice = pro.value?.salePrice ?? pro.value!.price! ;
    pro.value!.sumPrice = (pro.value?.salePrice ?? pro.value!.price!) * (pro.value?.quantity ?? 1) ;
    for(Additions add in selectedAdditions){
      int index = pro.value?.addititonsList?.indexWhere((element) => element.id ==add.id) ?? -1 ;
      pro.value?.addititonsList?[index].selected = true ;
      pro.value!.sumPrice = pro.value!.sumPrice! + ((add.price ?? 0) * (pro.value?.quantity ?? 1)).toDouble() ;
    }
    pro.refresh();
  }

  Future getItem() async{
    loading(true);
    final request = ItemRequest(id: itemId , index: 1);
    await RestaurantRepository().getItem(
      request,
      onComplete: () =>  loading(false),
      onError: (e) => showPopupText(e),
      onSuccess: (data)async {
                    await RestaurantStorage.isFavItem(data.data?.id ?? -1)
              .then((value) => data.data?.fav!(value));
        pro(data.data);
        timeSelected(timeSelected.value.add(Duration(minutes: pro.value?.time ?? 0)));
        timeSelected.refresh();
        pro.value?.itemImages?.add(ImageModel(image: pro.value?.image));
        String list = jsonEncode(pro.value!.attributeList);
        List _list = jsonDecode(list);
        attributeList(List<Attribute>.from(_list.map((e) => Attribute.fromJson(e))));
        calcAddPrice();
      }
    );
  }

  onAttributeChanged({required int i, required AttributeDetails term}){
    pro.value!.chooseValues.removeWhere((element) => element.headId == attributeList[i].id);
    pro.value!.chooseValues.add(term);
    // checkVariation(pro!.variationsList!, i);
    checkVariationNew();
    calcAddPrice();
  }

  void checkVariationNew(){
    try {
      final product = pro.value ;
      final variations = product!.variationsList!;
      final selectedTerms = product.chooseValues;

      product.selectedVariation = null;
      List<Variation> possibleVariations = List<Variation>.from(variations.map((e) => Variation.fromJson(e.toJson())));
      possibleVariations = possibleVariations.where((variation) => (variation.variationDetails??[]).every((element) => selectedTerms.any((term) => element.attributeDetailsId == term.id))).toList();
      if(possibleVariations.isEmpty){
        possibleVariations = possibleVariations.where((element) => (element.variationDetails??[]).length == 1 && selectedTerms.any((e) => e.id == (element.variationDetails??[]).single.id)).toList();
      }
      product.name = "${product.name!.split("-").first}-${selectedTerms.map((e) => e.value??"").join("-")}";
      if(possibleVariations.isNotEmpty){
        product.price = (possibleVariations.first.price??0).toDouble();
        product.sumPrice = product.price ;
        product.salePrice = (possibleVariations.first.salePrice??0).toDouble();
        product.selectedVariation = possibleVariations.first;
      } else {
        product.price =  product.priceNoAttribute;
        product.sumPrice = product.price ;
        product.salePrice =  product.salePriceNoAttribute;
      }
      pro(product);
      pro.refresh();
    } catch (e,s) {
      print("$e\n$s");
    }
  }


  addToCart(){
    pro.value?.requiredDate = timeSelected.value ;
    RestaurantCartManager().addToCart(pro.value!);
    showPopupText(AppStrings.addToCart);
  }

}
