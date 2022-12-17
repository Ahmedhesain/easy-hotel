// To parse this JSON data, do
//
//     final salesDetailsSpa = salesDetailsSpaFromJson(jsonString);

import 'dart:convert';

import 'package:easy_hotel/app/data/model/spa/dto/request/spa_save_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';




class HousekeepingSaveRequest {
  HousekeepingSaveRequest({
    this.serviceTypeId,
    this.branchId,
    this.createdBy,
    this.companyId,
    this.salesDetailHouseKeepingDTOList,
    this.customerId,
    this.date,
    this.time,
  });

  int? serviceTypeId;
  int? branchId;
  int?createdBy;
  int?companyId;
  List<int>? salesDetailHouseKeepingDTOList ;
  int? customerId ;
  DateTime? date ;
  DateTime? time ;

  factory HousekeepingSaveRequest.fromJson( dynamic json) => HousekeepingSaveRequest(
      serviceTypeId: json["serviceTypeId"] == null ? null : json["serviceTypeId"],
      customerId: json["customerId"] == null ? null : json["customerId"],
      createdBy: json["createdBy"] == null ? null : json["createdBy"],
      companyId: json["companyId"] == null ? null : json["companyId"],
      branchId: json["branchId"] == null ? null : json["branchId"],
      salesDetailHouseKeepingDTOList : json["salesDetailHouseKeepingDTOList"] == null ? null : List<int>.from(json["salesDetailHouseKeepingDTOList"].map((e) => SalesDetailsSpaItem.fromJson(e)))
  );

  Map<String, dynamic> toJson() => {
    "serviceTypeId": serviceTypeId == null ? null : serviceTypeId,
    "customerId": customerId == null ? null : customerId,
    "createdBy": createdBy == null ? null : createdBy,
    "companyId": companyId == null ? null : companyId,
    "branchId": branchId == null ? null : branchId,
    "date": date == null ? null : date?.toIso8601String(),
    "time": time == null ? null : time?.toIso8601String(),
    "salesDetailHouseKeepingDTOList": salesDetailHouseKeepingDTOList == null ? null : List<dynamic>.from(salesDetailHouseKeepingDTOList!.map((x) => x)),

  };
}
