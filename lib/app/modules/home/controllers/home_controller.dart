import 'package:easy_hotel/app/modules/hotels_search/controller/hotel_search_controller.dart';
import 'package:easy_hotel/app/modules/hotels_search/views/hotel_search_home_view.dart';
import 'package:easy_hotel/app/modules/my_account/acoount_homepage/controllers/my_account_controller.dart';
import 'package:easy_hotel/app/modules/my_account/acoount_homepage/views/my_account_view.dart';
import 'package:easy_hotel/app/modules/rooms/rooms_homepage/controllers/rooms_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../core/utils/user_manager.dart';
import '../../../core/values/app_constants.dart';
import '../../food/food_cart/controllers/food_cart_controller.dart';
import '../../rooms/rooms_homepage/views/rooms_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class HomeController extends GetxController {

  final pageIndex = 0.obs;
  List<Widget> pages = const[
    // RoomsView(),
    HotelSearchView(),
    MyAccountView(),
  ];
  final user = UserManager();

  @override
  void onInit() {
    Get.isRegistered<HotelSearchController>() ? Get.find<HotelSearchController>() : Get.put(HotelSearchController());
    Get.isRegistered<MyAccountController>() ? Get.find<MyAccountController>() : Get.put(MyAccountController());
    Get.isRegistered<FoodCartController>() ? Get.find<FoodCartController>() : Get.put<FoodCartController>(FoodCartController());
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
 
      firebaseMessaging.subscribeToTopic("${AppConstants.customer}_${user.user!.id!}");
       WidgetsBinding.instance.addPostFrameCallback((_) async {
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    });
    var initialzationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
                importance: Importance.max,
                priority: Priority.max,
                playSound: true,
            
              ),
            ));
              
            FirebaseMessaging.onMessageOpenedApp.listen((event) {
              print("sdsd");
            });
      }
    });
    // Get.isRegistered<RoomsController>() ? Get.find<RoomsController>() : Get.put(RoomsController());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  void changeView(int index) => pageIndex.value = index;
}
