// To parse this JSON data, do
//
//     final ordersResponse = ordersResponseFromJson(jsonString);

import 'dart:convert';

import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/model/halls/dto/response/halls_response.dart';

OrdersResponse? ordersResponseFromJson(String str) =>
    OrdersResponse.fromJson(json.decode(str));

String ordersResponseToJson(OrdersResponse? data) =>
    json.encode(data!.toJson());

class OrdersResponse {
  OrdersResponse(
      {this.id,
      this.appId,
      this.branchId,
      this.reviewId,
      this.itemId,
      this.name,
      this.image,
      this.cost,
      this.date,
      this.rate,
      this.reviewText,
      this.reviewDate,
      this.addtionsDTOList,
      this.delivered,
      this.statue,
      this.starNum,
      this.cancle});

  int? id;
  int? appId;
  int? branchId;
  int? reviewId;
  int? itemId;
  int? delivered;
  String? name;
  String? reviewText;
  String? statue;
  dynamic image;
  num? cost;
  num? starNum;
  int? cancle;

  DateTime? date;
  DateTime? reviewDate;
  double? rate;
  List<AddtionsModel>? addtionsDTOList;

  static List<OrdersResponse> fromList(dynamic json) =>
      List.from(json.map((e) => OrdersResponse.fromJson(e)));

  factory OrdersResponse.fromJson(dynamic json) {
    var statue = json["statue"];
    final delivered = json["delivered"];
    if (statue == null) {
      if (delivered == null) {
        statue = AppStrings.underProccess;
      } else if (delivered == 0) {
        statue = AppStrings.notDeliverd;
      } else if (delivered == 1) {
        statue = AppStrings.deliverd;
      }
    }

    return OrdersResponse(
      id: json["id"],
      branchId: json["branchId"],
      itemId: json["itemId"],
      appId: json["appId"],
      name: json["name"],
      delivered: delivered,
      statue: statue,
      reviewText: json["reviewText"],
      image: json["image"],
      starNum: json["starNum"] == null ? 0.0 : json["starNum"],
      cost: json["cost"] == null ? 0.0 : json["cost"],
      date: json["date"] == null ? null : DateTime.parse(json["date"]),
      reviewDate: json["reviewDate"] == null ? null : DateTime.parse(json["reviewDate"]),
      addtionsDTOList: json["addtionsDTOList"] == null ? null : List<AddtionsModel>.from(json["addtionsDTOList"].map((x) => x)),
      rate: json["rate"] == null ? null : json["rate"].toDouble(),
      reviewId: json["reviewId"] == null ? null : json["reviewId"],
      cancle: json["cancle"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchId": branchId,
        "itemId": itemId,
        "reviewId": reviewId,
        "appId": appId,
        "name": name,
        "reviewText": reviewText,
        "image": image,
        "cost": cost,
        "starNum": starNum,
        "date": date!.toIso8601String(),
        "reviewDate": reviewDate!.toIso8601String(),
        "rate": rate,
        "delivered": delivered,
        "statue": statue,
        "addtionsDTOList": addtionsDTOList == null ? null : List<dynamic>.from(addtionsDTOList!.map((x) => x.toJson())),
      };
}
