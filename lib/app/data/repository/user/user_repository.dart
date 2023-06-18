import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/data/model/generic/response/generic_response.dart';
import 'package:easy_hotel/app/data/model/user/dto/request/refresh_token_request_dto.dart';
import 'package:easy_hotel/app/data/model/user/dto/request/update_user_put_request.dart';
import 'package:easy_hotel/app/data/model/user/dto/response/refresh_token_response_dto.dart';
import 'package:easy_hotel/app/data/model/user/dto/response/update_user_put_response.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';

import '../../model/rooms/dto/request/customer_room_request.dart';
import '../../model/user/dto/request/client_message_save_request.dart';
import '../../model/user/dto/request/send_fcm_request.dart';

class UserRepository {

  // updateUser(
  //   UpdateUserPutRequest updateUserPutRequest, {
  //   Function()? beforeSend,
  //   Function(GenericResponse<UpdateUserPutResponse> data)? onSuccess,
  //   Function(dynamic error)? onError,
  // }) {
  //   final token = UserManager().token;
  //   ApiProvider().put<UpdateUserPutResponse>('User/UpdateProfile',
  //       beforeSend: beforeSend,
  //       token: token,
  //       data: updateUserPutRequest.toJson(),
  //       onSuccess: onSuccess,
  //       onError: onError);
  // }

      Future sendMessage(
      ClientMessageSaveRequest request, {
        SuccessFunc<void> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) async{
    await ApiProvider().post<void>(
        'clientMasseges/saveMessage',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: (_) {},
        onComplete: onComplete
    );
  }

    Future getRoomNumberByCustomerId(
      CustomerRoomRequest request, {
        SuccessFunc<int?> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) async{
    await ApiProvider().post<int?>(
        'customers/findRoomNumberByCustomerId',
        onSuccess: onSuccess,
        data: request.toJson(),
        onError: onError,
        convertor: (data) => data["data"],
        onComplete: onComplete
    );
  }

final String apiKey = "AAAAlEq9lFs:APA91bGrzO5fQDFJ6a16rMvXUlJFcMTjcNbpnZNeWeLfi4U88o1bdLh5GHJJeXsWxDF_9FNjCu5S8DcSAr3DRm0aoUhk-NJdDVO8mOJJ-JXY61BdEU2zPybeGCakj2geBpYQE3Gtmkga";
  
  sendNotification(
      SendFcmRequest request, {
        Function()? onComplete,
        Function(void)? onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<void>('https://fcm.googleapis.com/fcm/send',
        onComplete: onComplete,
        isFcmNotification: true,
        onSuccess: onSuccess,
        data: request.toJson(),
        header: {
          'Content-Type': 'application/json',
          "Authorization": "key=$apiKey"
        },
        onError: onError,
        convertor: (_) {  },
      );


}
