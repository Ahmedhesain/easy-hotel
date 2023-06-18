import 'package:easy_hotel/app/core/themes/app_theme.dart';
import 'package:easy_hotel/app/data/model/spa/dto/response/spa_search_response_dto.dart';
import 'package:easy_hotel/app/data/model/user/dto/response/refresh_token_response_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/model/auth/login/dto/response/login_response.dart';
import '../../data/model/user/dto/request/send_fcm_request.dart';
import '../../data/repository/user/user_repository.dart';
import '../../routes/app_pages.dart';
import '../values/app_constants.dart';
import '../values/app_strings.dart';
import '../values/languages/app_translation.dart';
import 'app_storage.dart';

class UserManager{
  static final _manager = UserManager._();
  UserManager._();
  factory UserManager() => _manager;

  bool get isLoggedIn => AppStorage.read(AppStorage.IS_LOGGED_IN) ?? false;
  String get token => AppStorage.read(AppStorage.TOKEN_KEY) ?? '';
  String get rToken => AppStorage.read(AppStorage.REFRESH_TOKEN_KEY) ?? '';
  // bool get isMale => user?.isMale == 1;
  // bool get isTokenExpired => DateTime.tryParse(AppStorage.read(AppStorage.TOKEN_EXPIRE_TIME_KEY)??'')?.isBefore(DateTime.now()) ?? false;

  LoginResponse? get user => AppStorage.read(AppStorage.USER) == null ? null : LoginResponse.fromJson(AppStorage.read(AppStorage.USER));
  HotelsearchModel? get selectedBranch => AppStorage.read(AppStorage.SELECTED_BRANCH) == null ? null : HotelsearchModel.fromJson(AppStorage.read(AppStorage.SELECTED_BRANCH));

  Future saveSelectedBranch(HotelsearchModel data)async{
   await AppStorage.write(AppStorage.SELECTED_BRANCH , data.toJson());
    debugPrint('branch updated');
  }

  login(LoginResponse data) {
    AppStorage.write(AppStorage.IS_LOGGED_IN, true);
    AppStorage.write(AppStorage.USER, data.toJson());
    // AppStorage.write(AppStorage.TOKEN_KEY, data.accessToken);
    // AppStorage.write(AppStorage.TOKEN_EXPIRE_TIME_KEY, data.expiresIn);
  }

  Future logout() async{
    final isDark = AppTheme().isSavedDarkMode();
    var lang = AppStorage.read(AppStorage.LANGUAGE_KEY);
    await AppStorage.removeAll();
    await AppStorage.write(AppStorage.LANGUAGE_KEY, lang);
    AppTranslation().saveLocale(AppTranslation.getLocale());
    AppTheme().changeThemeMode(isDark);
    Get.forceAppUpdate();
    Get.toNamed(Routes.LOGIN);
  }

  // Future updateToken(RefreshTokenResponse data) async {
  //   await AppStorage.write(AppStorage.TOKEN_KEY, data.token);
  //   await AppStorage.write(AppStorage.REFRESH_TOKEN_KEY, data.refreshToken);
  //   await AppStorage.write(AppStorage.TOKEN_EXPIRE_TIME_KEY, data.expireDate.toIso8601String());
  // }

  
  sendNewOrderNotification(String topic){
    UserRepository().sendNotification(
      SendFcmRequest(body: AppStrings.newOrderbody , title:AppStrings.newOrder , tobic: topic ),
      onError: (error) => printError());
  }



}