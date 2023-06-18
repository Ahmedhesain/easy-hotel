import 'package:easy_hotel/app/data/model/base_request.dart';

class ReviewRequestDto extends BaseRequest {
  ReviewRequestDto({
    this.invOrganizationId,
    this.itemId,
    this.reviewText,
    this.reviewId,
    this.createdBy,
    this.branchId,
    this.companyId,
    this.rate,
    this.appId,
    this.detailId,
    this.id
  });

  int? invOrganizationId;
  int? itemId;
  String? reviewText;
  int? reviewId;
  int? createdBy;
  int? branchId;
  int? companyId;
  int? rate;
  int? appId;
  int? id;
  int? detailId;


  @override
  Map<String, dynamic> toJson() => {
    "invOrganizationId": invOrganizationId,
    "itemId": itemId,
    "reviewText": reviewText,
    "reviewId": reviewId,
    "createdBy": createdBy,
    "branchId": branchId,
    "companyId": companyId,
    "rate": rate,
    "appId": appId,
    "detailId": detailId,
     "id": id ,
  };
}
