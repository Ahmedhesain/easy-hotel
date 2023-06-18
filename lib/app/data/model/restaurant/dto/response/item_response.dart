




import 'package:easy_hotel/app/data/model/restaurant/dto/response/sales_details_additions.dart';
import 'package:easy_hotel/app/data/model/restaurant/dto/response/variation_model.dart';
import 'package:get/get.dart';

import '../../../../../modules/food/food_cart/controllers/food_cart_controller.dart';
import '../../../spa/dto/response/spa_response_dto.dart';
import 'attribute_details_model.dart';
import 'attribute_model.dart';

class ItemResponse {
  ItemResponse({
    this.id,
    this.markEdit,
    this.msg,
    this.msgType,
    this.markDisable,
    this.createdBy,
    this.index,
    this.companyId,
    this.createdByName,
    this.branchId,
    this.deletedBy,
    this.igmaOwnerId,
    this.serial,
    this.name,
    this.groupId,
    this.price,
    this.priceNoAttribute,
    this.time,
    this.discribtion,
    this.unitId,
    this.remark,
    this.image,
    this.appId,
    this.saleItem,
    this.salePrice,
    this.salePriceNoAttribute,
    this.attributeList ,
    this.variationsList ,
    this.addititonsList ,
    this.quantity ,
    required this.fav ,
    this.itemImages ,
    this.selectedVariation,
    this.reviewsList ,
    this.reviewsStars,
    this.resSalesDetailsAdditionsDTOList,
    this.discountType,
    this.discountValue,
    this.sumPrice,
    this.discountRate,
    // this.chooseValues ,
    this.saved,
    this.offerId,
    this.oldDetailId,
    this.oldHeadPackUpId,
    this.requiredDate
  }) : localId = idCount++;

  static int idCount = 0;
  int localId = -1;
  int? id;
  bool? markEdit;
  dynamic msg;
  dynamic msgType;
  dynamic markDisable;
  int? createdBy;
  int? index;
  int? companyId;
  int? oldHeadPackUpId;
  String? createdByName;
  int? branchId;
  int? deletedBy;
  int? igmaOwnerId;
  int? serial;
  String? name;
  int? groupId;
  int? offerId;
  List<SalesDetailsAdditions>? resSalesDetailsAdditionsDTOList = [];
  double? price;
  double? discountValue;
  int? discountType;
  double? discountRate;
  final double? priceNoAttribute;
  dynamic time;
  String? discribtion;
  int? unitId;
  String? remark;
  String? image;
  int? appId;
  bool? saleItem;
  double? salePrice;
  final double? salePriceNoAttribute;
  num? quantity = 1.0;
  List<Attribute>? attributeList;
  List<Variation>? variationsList = [];
  List<Additions>? addititonsList = [];
  List<ImageModel>? itemImages ;
  List<ReviewModel>? reviewsList;
  List<AttributeDetails> chooseValues = [];
  double? reviewsStars ;
  RxBool fav = false.obs;
  Variation? selectedVariation;
  double? sumPrice ;
  bool? saved ;
  int? oldDetailId ;
  DateTime? requiredDate ;


  calcSumPrice(){
    sumPrice = salePrice ?? price! ;
    sumPrice = (salePrice ?? price!) * (quantity ?? 1) ;
    for(Additions add in addititonsList ?? []){
      add.selected ?? false == true  ?
      sumPrice = sumPrice! + ((add.price ?? 0) * (quantity ?? 1)).toDouble() : null;
    }
     Get.find<FoodCartController>().calcTotalPrice();
  }

  static List<ItemResponse> fromList(dynamic json) => List<ItemResponse>.from(json.map((e) =>ItemResponse.fromJson(e)));

  factory ItemResponse.fromJson(dynamic json) {
    final product =  ItemResponse(
    id: json["id"],
    oldHeadPackUpId: json["oldHeadPackUpId"],
    offerId: json["offerId"],
    markEdit: json["markEdit"],
    msg: json["msg"],
    msgType: json["msgType"],
    markDisable: json["markDisable"],
    createdBy: json["createdBy"],
    index: json["index"],
    companyId: json["companyId"],
    createdByName: json["createdByName"],
    branchId: json["branchId"],
    deletedBy: json["deletedBy"],
    discountValue: json["discountValue"],
    discountRate: json["discountRate"],
    discountType: json["discountType"],
    igmaOwnerId: json["igmaOwnerId"],
    serial: json["serial"],
    name: json["name"],
    groupId: json["groupId"],
    price: json["price"],
    priceNoAttribute: json["price"],
    time: json["time"],
    discribtion: json["discribtion"],
    unitId: json["unitId"],
    remark: json["remark"],
    image: json["image"],
    appId: json["appId"],
    saleItem: json["saleItem"],
    salePrice: json["salePrice"],
    sumPrice : json["sumPrice"],
    salePriceNoAttribute: json["salePrice"],
    attributeList: List<Attribute>.from((json["attributeList"]??[]).map((x) => Attribute.fromJson(x))),
    variationsList: List<Variation>.from((json["variationsList"]??[]).map((x) => Variation.fromJson(x))),
    addititonsList: List<Additions>.from((json["addtionsDTOList"]??[]).map((x) => Additions.fromJson(x))),
    itemImages:   List<ImageModel>.from((json["itemImages"]??[]).map((x) => ImageModel.fromJson(x))),
    reviewsList:   List<ReviewModel>.from((json["reviewsList"]??[]).map((x) => ReviewModel.fromJson(x))),
    resSalesDetailsAdditionsDTOList: List<SalesDetailsAdditions>.from((json["resSalesDetailsAdditionsDTOList"]??[]).map((x) => SalesDetailsAdditions.fromJson(x))),
    quantity: json["quantity"] ?? 1 ,
    reviewsStars: json["reviewsStars"] ,
    requiredDate: json["requiredDate"] != null ? DateTime.tryParse(json["requiredDate"]) : DateTime.now().add(Duration(minutes: json["time"] ?? 0)),
    fav : false.obs ,
    saved : false ,
    selectedVariation: json["selectedVariation"] == null ? null : Variation.fromJson(json["selectedVariation"]),
  );
    product.chooseValues = List<AttributeDetails>.from((json["chooseValues"] ?? []).map((x) => AttributeDetails.fromJson(x)));
    return product;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "oldHeadPackUpId": oldHeadPackUpId,
    "markEdit": markEdit,
    "offerId": offerId,
    "msg": msg,
    "msgType": msgType,
    "markDisable": markDisable,
    "createdBy": createdBy,
    "index": index,
    "companyId": companyId,
    "createdByName": createdByName,
    "branchId": branchId,
    "deletedBy": deletedBy,
    "igmaOwnerId": igmaOwnerId,
    "serial": serial,
    "name": name,
    "discountType": discountType,
    "discountRate": discountRate,
    "discountValue": discountValue,
    "groupId": groupId,
    "price": price,
    "priceNoAttribute": priceNoAttribute,
    "time": time,
    "discribtion": discribtion,
    "unitId": unitId,
    "remark": remark,
    "image": image,
    "appId": appId,
    "saleItem": saleItem,
    "salePrice": salePrice,
    "salePriceNoAttribute": salePriceNoAttribute,
    "attributeList":  List<dynamic>.from((attributeList??[]).map((x) => x.toJson())),
    "variationsList":  List<dynamic>.from((variationsList??[]).map((x) => x.toJson())),
    "addtionsDTOList":  List<dynamic>.from((addititonsList??[]).map((x) => x.toJson())),
    "chooseValues": List<dynamic>.from(chooseValues.map((x) => x!.toJson())),
    "resSalesDetailsAdditionsDTOList": List<dynamic>.from((resSalesDetailsAdditionsDTOList??[]).map((x) => x!.toJson())),
    "reviewsList" : List<dynamic>.from((reviewsList??[]).map((e) => e.toJson())),
    "reviewsStars" : reviewsStars ,
    "itemImages" : List<dynamic>.from((itemImages??[]).map((x) => x.toJson())),
    "quantity" : quantity ,
    "sumPrice" : sumPrice ,
    "requiredDate" : requiredDate?.toIso8601String() ,
    "selectedVariation" : selectedVariation == null ? null :  selectedVariation!.toJson()
  };
}



class Additions {
  Additions({
    this.id,
    this.resId,
    this.msg,
    this.msgType,
    this.markDisable,
    this.createdBy,
    this.createdDate,
    this.index,
    this.companyId,
    this.createdByName,
    this.branchId,
    this.deletedBy,
    this.deletedDate,
    this.igmaOwnerId,
    this.name,
    this.price,
    this.appId,
    this.appName,
    this.selected,
    this.mainAdditionId ,
    this.headPackUpId ,
    this.isCloud ,
    this.saved
  });
  bool? selected = false;
  int? id;
  int? resId;
  dynamic msg;
  dynamic msgType;
  dynamic markDisable;
  int? createdBy;
  dynamic createdDate;
  int? index;
  dynamic companyId;
  dynamic createdByName;
  dynamic branchId;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic igmaOwnerId;
  String? name;
  double? price;
  int? appId;
  String? appName;
  int? mainAdditionId;
  bool? saved ;
  int? headPackUpId;
  int? isCloud;

  SalesDetailsAdditions get toSalesDetailsAddition{
    return SalesDetailsAdditions(
      additionName: name,
      price: price,
      salePrice: price,
      additionId: id,
    );
  }

  factory Additions.fromJson(Map<String, dynamic> json) => Additions(
    id: json["id"],
    resId: json["resId"],
    headPackUpId: json["headPackUpId"],
    isCloud: json["isCloud"],
    msg: json["msg"],
    msgType: json["msgType"],
    markDisable: json["markDisable"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    index: json["index"],
    companyId: json["companyId"],
    createdByName: json["createdByName"],
    branchId: json["branchId"],
    deletedBy: json["deletedBy"],
    deletedDate: json["deletedDate"],
    igmaOwnerId: json["igmaOwnerId"],
    name: json["name"],
    price: json["price"],
    appId: json["appId"],
    appName: json["appName"],
    selected: json["selected"] ?? false ,
    mainAdditionId:json["mainAdditionId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "resId": resId,
    "headPackUpId": headPackUpId,
    "isCloud": isCloud,
    "msg": msg,
    "msgType": msgType,
    "markDisable": markDisable,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "index": index,
    "companyId": companyId,
    "createdByName": createdByName,
    "branchId": branchId,
    "deletedBy": deletedBy,
    "deletedDate": deletedDate,
    "igmaOwnerId": igmaOwnerId,
    "name": name,
    "price": price,
    "appId": appId,
    "appName": appName,
    "selected" : selected,
    "mainAdditionId" : mainAdditionId
  };
}


class ImageModel {
  ImageModel({
    this.id,
    this.markEdit,
    this.msg,
    this.msgType,
    this.markDisable,
    this.createdBy,
    this.createdDate,
    this.index,
    this.companyId,
    this.createdByName,
    this.branchId,
    this.deletedBy,
    this.deletedDate,
    this.igmaOwnerId,
    this.companyCode,
    this.branchSerial,
    this.igmaOwnerSerial,
    this.userCode,
    this.itemId,
    this.image,
  });

  int? id;
  bool? markEdit;
  dynamic msg;
  dynamic msgType;
  dynamic markDisable;
  int? createdBy;
  dynamic createdDate;
  int? index;
  dynamic companyId;
  dynamic createdByName;
  dynamic branchId;
  dynamic deletedBy;
  dynamic deletedDate;
  dynamic igmaOwnerId;
  dynamic companyCode;
  dynamic branchSerial;
  dynamic igmaOwnerSerial;
  dynamic userCode;
  int? itemId;
  String? image;

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json["id"],
    markEdit: json["markEdit"],
    msg: json["msg"],
    msgType: json["msgType"],
    markDisable: json["markDisable"],
    createdBy: json["createdBy"],
    createdDate: json["createdDate"],
    index: json["index"],
    companyId: json["companyId"],
    createdByName: json["createdByName"],
    branchId: json["branchId"],
    deletedBy: json["deletedBy"],
    deletedDate: json["deletedDate"],
    igmaOwnerId: json["igmaOwnerId"],
    companyCode: json["companyCode"],
    branchSerial: json["branchSerial"],
    igmaOwnerSerial: json["igmaOwnerSerial"],
    userCode: json["userCode"],
    itemId: json["itemId"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "markEdit": markEdit,
    "msg": msg,
    "msgType": msgType,
    "markDisable": markDisable,
    "createdBy": createdBy,
    "createdDate": createdDate,
    "index": index,
    "companyId": companyId,
    "createdByName": createdByName,
    "branchId": branchId,
    "deletedBy": deletedBy,
    "deletedDate": deletedDate,
    "igmaOwnerId": igmaOwnerId,
    "companyCode": companyCode,
    "branchSerial": branchSerial,
    "igmaOwnerSerial": igmaOwnerSerial,
    "userCode": userCode,
    "itemId": itemId,
    "image": image,
  };
}


