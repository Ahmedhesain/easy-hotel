import 'package:easy_hotel/app/modules/food_section/bindings/food_section_binding.dart';
import 'package:easy_hotel/app/modules/food_section/views/food_section_view.dart';
import 'package:easy_hotel/app/modules/forget_password/views/forget_password_view.dart';
import 'package:easy_hotel/app/modules/halls/city_halls/bindings/city_halls_page_binding.dart';
import 'package:easy_hotel/app/modules/halls/city_halls/views/city_halls_page_view.dart';

import 'package:easy_hotel/app/modules/halls/hall_cleander/bindings/hall_calender_page_binding.dart';
import 'package:easy_hotel/app/modules/halls/hall_cleander/views/hall_calender_page_view.dart';
import 'package:easy_hotel/app/modules/halls/hall_detail/bindings/hall_details_binding.dart';
import 'package:easy_hotel/app/modules/halls/hall_detail/views/hall_detail_view.dart';
import 'package:easy_hotel/app/modules/halls/hall_reservation/bindings/hall_reservation_page_binding.dart';
import 'package:easy_hotel/app/modules/halls/hall_reservation/views/hall_reservation_page_view.dart';
import 'package:easy_hotel/app/modules/halls/halls_homepage/bindings/halls_binding.dart';
import 'package:easy_hotel/app/modules/halls/halls_homepage/views/halls_view.dart';
import 'package:easy_hotel/app/modules/halls/halls_search/bindings/halls_search_page_binding.dart';
import 'package:easy_hotel/app/modules/halls/halls_search/views/halls_search_page_view.dart';
import 'package:easy_hotel/app/modules/halls/hotel_halls/bindings/hotel_halls_page_binding.dart';
import 'package:easy_hotel/app/modules/halls/hotel_halls/views/hotel_halls_page_view.dart';
import 'package:easy_hotel/app/modules/halls/search_filter_city/bindings/search_filter_page_binding.dart';
import 'package:easy_hotel/app/modules/halls/search_filter_city/views/search_filter_page_view.dart';
import 'package:easy_hotel/app/modules/halls/search_filter_hotel/bindings/search_filter_hotel_page_binding.dart';
import 'package:easy_hotel/app/modules/halls/search_filter_hotel/views/search_filter_hotel_page_view.dart';
import 'package:easy_hotel/app/modules/hotels_search/views/hotel_search_home_view.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_home_page/bindings/house_keeping_binding.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_home_page/views/house_keeping_view.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_reservation/bindings/house_keeping_reservation_binding.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_reservation/views/house_keeping_reservation_view.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_services/bindings/house_keeping_services_binding.dart';
import 'package:easy_hotel/app/modules/house_keeping/housekeeping_services/views/house_keeping_services_view.dart';
import 'package:easy_hotel/app/modules/my_account/views/my_account_view.dart';
import 'package:easy_hotel/app/modules/rooms/all_rooms/bindings/all_rooms_page_binding.dart';
import 'package:easy_hotel/app/modules/rooms/all_rooms/views/all_rooms_page_view.dart';
import 'package:easy_hotel/app/modules/rooms/room_detail/bindings/room_details_binding.dart';
import 'package:easy_hotel/app/modules/rooms/room_detail/views/room_detail_view.dart';
import 'package:easy_hotel/app/modules/rooms/room_search/bindings/room_search_page_binding.dart';
import 'package:easy_hotel/app/modules/rooms/room_search/views/room_search_page_view.dart';
import 'package:easy_hotel/app/modules/rooms/room_search_filter/bindings/room_search_filter_page_binding.dart';
import 'package:easy_hotel/app/modules/rooms/room_search_filter/views/room_search_filter_page_view.dart';
import 'package:easy_hotel/app/modules/rooms/rooms_homepage/bindings/rooms_binding.dart';
import 'package:easy_hotel/app/modules/rooms/rooms_homepage/views/rooms_view.dart';
import 'package:easy_hotel/app/modules/spa/spa_city/bindings/spa_city_binding.dart';
import 'package:easy_hotel/app/modules/spa/spa_city/views/spa_city_view.dart';
import 'package:easy_hotel/app/modules/spa/spa_home/views/spa_view.dart';
import 'package:get/get.dart';
import '../modules/allServices/bindings/all_services_binding.dart';
import '../modules/allServices/views/all_services_view.dart';
import '../modules/cars/cars_category/bindings/cars_category_binding.dart';
import '../modules/cars/cars_category/views/cars_category_view.dart';
import '../modules/cars/cars_main/bindings/cars_main_binding.dart';
import '../modules/cars/cars_main/views/cars_main_view.dart';
import '../modules/cars/cars_order/bindings/cars_order_binding.dart';
import '../modules/cars/cars_order/views/cars_order_view.dart';
import '../modules/food_cart/bindings/food_cart_binding.dart';
import '../modules/food_cart/views/food_cart_view.dart';
import '../modules/forget_password/bindings/forget_password_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/hotels_search/bindings/hotel_search_binding.dart';
import '../modules/hotels_search/views/hotel_search_search_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/my_account/bindings/my_account_binding.dart';
import '../modules/polman/bindings/polman_binding.dart';
import '../modules/polman/views/polman_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/resturant/bindings/resturant_binding.dart';
import '../modules/resturant/views/resturant_view.dart';
import '../modules/spa/spa_detail/bindings/spa_details_binding.dart';
import '../modules/spa/spa_detail/views/spa_detail_view.dart';
import '../modules/spa/spa_home/bindings/spa_binding.dart';
import '../modules/spa/spa_hotel/bindings/spa_hotel_binding.dart';
import '../modules/spa/spa_hotel/views/spa_hotel_view.dart';
import '../modules/spa/spa_search/bindings/spa_search_page_binding.dart';
import '../modules/spa/spa_search/views/spa_search_page_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      // children: [
      //   GetPage(
      //     name: _Paths.HOME,
      //     page: () => const HomeView(),
      //     binding: HomeBinding(),
      //   ),
      // ],
    ),
    GetPage(name: _Paths.HOTEL_SEARCH_FOR_SERVICES, page: () => const HotelSearchView(), binding: HotelSearchBinding()),
    GetPage(name: _Paths.HOTEL_SEARCH_SEARCH_PAGE, page: () => const HotelSearchSearchView(), binding: HotelSearchBinding()),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSWORD,
      page: () => const ForgetPasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ALLSERVICES,
      page: () => const AllServicesView(),
      binding: AllServicesBinding(),
    ),
    GetPage(
      name: _Paths.SPA,
      page: () => const SpaView(),
      binding: SpaBinding(),
    ),
    GetPage(
      name: _Paths.RESTURANT,
      page: () => const ResturantView(),
      binding: ResturantBinding(),
    ),
    GetPage(
      name: _Paths.HALLS,
      page: () => const HallsView(),
      binding: HallsBinding(),
    ),
    GetPage(
      name: _Paths.CARS,
      page: () => const CarsMainView(),
      binding: CarsMainBinding(),
    ),
    GetPage(
      name: _Paths.HOUSE_KEEPING,
      page: () => const HouseKeepingView(),
      binding: HouseKeepingBinding(),
    ),
    GetPage(
      name: _Paths.ROOMS,
      page: () => const RoomsView(),
      binding: RoomsBinding(),
    ),
    GetPage(
      name: _Paths.POLMAN,
      page: () => const PolmanView(),
      binding: PolmanBinding(),
    ),
    GetPage(
      name: _Paths.SPA_SEARCH_PAGE,
      page: () => const SpaSearchPageView(),
      binding: SpaSearchPageBinding(),
    ),
    GetPage(
      name: _Paths.SPA_CITY,
      page: () => const SpaCityView(),
      binding: SpaCityBinding(),
    ),
    GetPage(
      name: _Paths.SPA_HOTEL,
      page: () => const SpaHotelView(),
      binding: SpaHotelBinding(),
    ),
    GetPage(
      name: _Paths.SPA_DETAILS,
      page: () => const SpaDetailView(),
      binding: SpaDetailsBinding(),
    ),
    GetPage(
      name: _Paths.HOUSEKEEPING_SERVICES,
      page: () => const HouseKeepingServicesView(),
      binding: HouseKeepingServicesBinding(),
    ),
    GetPage(
      name: _Paths.HOUSEKEEPING_RESERVATION,
      page: () => const HouseKeepingReservationView(),
      binding: HouseKeepingReservationBinding(),
    ),
    GetPage(
      name: _Paths.HALLS_SEARCH,
      page: () => const HallsSearchPageView(),
      binding: HallsSearchPageBinding(),
    ),
    GetPage(
      name: _Paths.CITY_HALLS,
      page: () => const CityHallsPageView(),
      binding: CityHallsPageBinding(),
    ),
    GetPage(
      name: _Paths.HOTEL_HALLS,
      page: () => const HotelHallsPageView(),
      binding: HotelHallsPageBinding(),
    ),
    GetPage(
      name: _Paths.HALL_DETAILS,
      page: () => const HallDetailView(),
      binding: HallDetailsBinding(),
    ),
    GetPage(
      name: _Paths.FOOD_SECTION,
      page: () => const FoodSectionView(),
      binding: FoodSectionBinding(),
    ),
    // GetPage(
    //   name: _Paths.FOOD_ITEM,
    //   page: () => const FoodItemView(),
    //   binding: FoodItemBinding(),
    // ),
    GetPage(
      name: _Paths.carsCategory,
      page: () => const CarsCategoryView(),
      binding: CarsCategoryBinding(),
    ),
    GetPage(
      name: _Paths.carsOrder,
      page: () => const CarsOrderView(),
      binding: CarsOrderBinding(),
    ),
    // GetPage(
    //   name: _Paths.FOOD_ITEM,
    //   page: () => const FoodItemView(),
    //   binding: FoodItemBinding(),
    // ),
    GetPage(
      name: _Paths.HALL_RESERVATION,
      page: () => const HallReservationPageView(),
      binding: HallReservationPageBinding(),
    ),
    GetPage(
      name: _Paths.HALL_CALENDER,
      page: () => const HallCalenderPageView(),
      binding: HallCalenderPageBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_SEARCH,
      page: () => const RoomSearchPageView(),
      binding: RoomSearchPageBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_SEARCH_FILTER,
      page: () => const RoomSearchFilterPageView(),
      binding: RoomSearchFilterPageBinding(),
    ),
    GetPage(
      name: _Paths.ALL_ROOMS,
      page: () => const AllRoomsPageView(),
      binding: AllRoomsPageBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_DETAIL,
      page: () => const RoomDetailView(),
      binding: RoomDetailBinding(),
    ),
    GetPage(
      name: _Paths.FOOD_CART,
      page: () => const FoodCartView(),
      binding: FoodCartBinding(),
    ),
    GetPage(
      name: _Paths.HALLS_SEARCH_FILTER,
      page: () => const HallSearchFilterPageView(),
      binding: HallSearchFilterPageBinding(),
    ),
    GetPage(
      name: _Paths.HALLS_SEARCH_FILTER,
      page: () => const HotelHallsPageView(),
      binding: HotelHallsPageBinding(),
    ),
    GetPage(
      name: _Paths.HALLS_SEARCH_HOTEL_FILTER,
      page: () => const HallSearchFilterHotelPageView(),
      binding: HallSearchFilterHotelPageBinding(),
    ),
    GetPage(
      name: _Paths.MY_ACCOUNT,
      page: () => const MyAccountView(),
      binding: MyAccountBinding(),
    ),
  ];
}
