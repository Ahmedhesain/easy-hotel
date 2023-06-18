import 'package:easy_hotel/app/data/model/auth/forget_password/dto/request/forget_password_request_dto.dart';
import 'package:easy_hotel/app/data/model/auth/login/dto/request/login_request.dart';
import 'package:easy_hotel/app/data/model/auth/login/dto/response/login_response.dart';
import 'package:easy_hotel/app/data/model/auth/register/dto/request/all_cities_request.dart';
import 'package:easy_hotel/app/data/model/auth/register/dto/request/all_currency_request.dart';
import 'package:easy_hotel/app/data/model/auth/register/dto/request/register_request.dart';
import 'package:easy_hotel/app/data/model/auth/register/dto/response/all_currency_response.dart';
import 'package:easy_hotel/app/data/model/auth/register/dto/response/all_languages_response.dart';
import 'package:easy_hotel/app/data/model/auth/register/dto/response/register_response.dart';
import 'package:easy_hotel/app/data/model/base_request.dart';
import 'package:easy_hotel/app/data/model/rooms/dto/request/cities_request_dto.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/city_edit_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/currency_edit_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/language_edit_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/orders_detail_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/orders_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/password_edit_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/personal_info_edit_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/request/review_request.dart';
import 'package:easy_hotel/app/data/model/setting/dto/response/orders_response_dto.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';

import '../../model/auth/register/dto/response/all_cities_response.dart';
import '../../model/setting/dto/request/cancle_request.dart';

class SettingRepository {


  editCurrency(
      EditCurrencyRequestDto request, {
        SuccessFunc<void> onSuccess, Function()?onComplete,
        Function(dynamic error)? onError,
        // Function()? onComplete,
      }) {
    ApiProvider().post<void>(
      'invOrganization/updateCurrency',
      data: request.toJson(),
      onSuccess: onSuccess,
      onComplete: onComplete,
      onError: onError,
      convertor: (_){return;},
      // onComplete: onComplete

    );
  }


  editLanguage(
      EditLanguageRequestDto request, {
        SuccessFunc<void> onSuccess, Function()?onComplete,
        Function(dynamic error)? onError,
        // Function()? onComplete,
      }) {
    ApiProvider().post<void>(
      'invOrganization/updateLaguage',
      data: request.toJson(),
      onSuccess: onSuccess,
      onComplete: onComplete,
      onError: onError,
      convertor: (_){return;},
      // onComplete: onComplete

    );
  }


  editCity(
      EditCityRequestDto request, {
        SuccessFunc<void> onSuccess, Function()?onComplete,
        Function(dynamic error)? onError,
        // Function()? onComplete,
      }) {
    ApiProvider().post<void>(
      'invOrganization/updateCity',
      data: request.toJson(),
      onSuccess: onSuccess,
      onComplete: onComplete,
      onError: onError,
      convertor: (_){return;},
      // onComplete: onComplete

    );
  }
  editPersonalInfo(
      EditPersonalInfoRequestDto request, {
        SuccessFunc<void> onSuccess, Function()?onComplete,
        Function(dynamic error)? onError,
        // Function()? onComplete,
      }) {
    ApiProvider().post<void>(
      'invOrganization/updatePhoneAndName',
      data: request.toJson(),
      onSuccess: onSuccess,
      onComplete: onComplete,
      onError: onError,
      convertor: (_){return;},
      // onComplete: onComplete

    );
  }
  editPassword(
      EditPaswordRequestDto request, {
        SuccessFunc<void> onSuccess, Function()?onComplete,
        Function(dynamic error)? onError,
        // Function()? onComplete,
      }) {
    ApiProvider().post<void>(
      'invOrganization/updatePassword',
      data: request.toJson(),
      onSuccess: onSuccess,
      onComplete: onComplete,
      onError: onError,
      convertor: (_){return;},
      // onComplete: onComplete

    );
  }
  saveReview(
      ReviewRequestDto request, {
        SuccessFunc<void> onSuccess, Function()?onComplete,
        Function(dynamic error)? onError,
        // Function()? onComplete,
      }) {
    ApiProvider().post<void>(
      'invOrganization/saveReview',
      data: request.toJson(),
      onSuccess: onSuccess,
      onComplete: onComplete,
      onError: onError,
      convertor: (_){return;},
      // onComplete: onComplete

    );
  }
  getOrders(
      OrdersRequestDto ordersRequestDto, {
        Function()? onComplete,
        SuccessFunc<List<OrdersResponse>> onSuccess,
        Function(dynamic error)? onError,
      }) =>
      ApiProvider().post<List<OrdersResponse>>('invOrganization/cutomerOrders',
        onComplete: onComplete,
        onSuccess: onSuccess,
        data: ordersRequestDto.toJson(),
        onError: onError,
        convertor: OrdersResponse.fromList,
      );
  getOrdersDetail(
      OrdersDetailRequestDto ordersDetailRequestDto, {
        SuccessFunc<OrdersResponse> onSuccess,
        Function(dynamic error)? onError,  Function()?onComplete,
      }) {
    ApiProvider().post<OrdersResponse>(
        'invOrganization/cutomerOrderDetail',
        onSuccess: onSuccess,
        data: ordersDetailRequestDto.toJson(),
        onError: onError,
        convertor: OrdersResponse.fromJson,
        onComplete: onComplete
    );
  }

  cancle(
      CancleRequestDto request, {
        SuccessFunc<void> onSuccess, Function()?onComplete,
        Function(dynamic error)? onError,
        // Function()? onComplete,
      }) {
    ApiProvider().post<void>(
      'invOrganization/cancleorder',
      data: request.toJson(),
      onSuccess: onSuccess,
      onComplete: onComplete,
      onError: onError,
      convertor: (_){return;},
      // onComplete: onComplete

    );
  }
}
