import 'package:easy_hotel/app/data/model/base_request.dart';

class CancleRequestDto extends BaseRequest {
  CancleRequestDto({
    this.id,
    this.appId

  });

  int? id;
  int? appId ;


  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "appId" : appId

  };
}
