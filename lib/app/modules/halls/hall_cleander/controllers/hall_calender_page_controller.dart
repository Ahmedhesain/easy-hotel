import 'package:easy_hotel/app/data/model/halls/dto/request/halls_save_request.dart';
import 'package:easy_hotel/app/data/repository/halls/halls_repository.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../../../../core/utils/show_popup_text.dart';
import '../../../../core/utils/user_manager.dart';
import '../../../../core/values/app_constants.dart';
import '../../../../core/values/app_strings.dart';
import '../../../../data/model/halls/dto/request/halls_period_request.dart';
import '../../../../data/model/halls/dto/response/halls_periods_response.dart';


class HallCalenderPageController extends GetxController {
  final isLoading = false.obs;
  final isPeriodLoading = false.obs;
  final List args = Get.arguments;
  final selectedDay = DateTime.now().obs;
  final Rxn<HallsPeriodsResponse> selectedPeriod = Rxn();
  final selectedDaysList = <HallsPeriodsResponse>[].obs;
  final hallPeriods = <HallsPeriodsResponse>[].obs;
  final hallReservedPeriods = <HallsPeriodsResponse>[].obs;
  final dayTotalPrice = 0.0.obs;
  final allTotalPrice = 0.0.obs;
  final user = UserManager();
  @override
  onInit()async {
    super.onInit();
    calcAllTotalPrice();
   await getHallPeriod();
   await getHallReservedPeriod(selectedDay.value);
  }

  calcAllTotalPrice() {
    if(selectedDaysList.toList().isEmpty){
      dayTotalPrice.value = args[2] ;
      allTotalPrice.value = args[2] ;
      return ;
    }
    allTotalPrice.value = (dayTotalPrice.value * selectedDaysList.length );
  }

  reset() {
    selectedDay(DateTime.now());
    selectedPeriod.value = null;
    hallReservedPeriods([]);
    resetPeriodEnabled();
  }

  addDay() {
    if (selectedPeriod.value == null) {
      showPopupText(AppStrings.shouldSelectPeriod.tr);
      return;
    }
    final day = HallsPeriodsResponse(id: selectedPeriod.value!.id, date: selectedDay.value , name:selectedPeriod.value!.name );
    selectedDaysList.add(day);
    calcAllTotalPrice();
    reset();
  }

  deleteDay(int index){
    selectedDaysList.removeAt(index);
    calcAllTotalPrice();
  }

  setSelectedPeriod(HallsPeriodsResponse val) {
    selectedPeriod(val);
  }

  setSelectedDay(DateTime date) {
    selectedDay(date);
    getHallReservedPeriod(date);
  }

  getHallSave() async {
    isLoading(true);
    if(selectedDaysList.toList().isEmpty){
      showPopupText(AppStrings.shouldSelectDays.tr);
      return ;
    }
    final request = HallsSaveRequest(
      currencySerial: 1,
      hallId: args[0].id,
      addtionsDTOList: args[1],
      companyId: AppConstants.companyId,
      createdBy: AppConstants.createdBy,
      customerId: UserManager().user!.id,
      branchId: args[0].branchId,
      remark : args[3],
      holePeriodIdList: selectedDaysList.toList()
    );
    HallsRepository().getHallSave(request,
        onSuccess: (data) {
          showPopupText(data.msg);
          UserManager().sendNewOrderNotification(AppConstants.halls);
          Get.offNamed(Routes.HALLS , arguments: args[0].branchId);
        },
        onError: (e) => showPopupText(e.toString()),
        onComplete: () => isLoading(false));
  }

  Future getHallPeriod() async {
    isPeriodLoading(true);
    final request = HallsPeriodsRequest(
      id: args[0].id,
      branchId: user.selectedBranch!.id!
    );
   await HallsRepository().getHallPeriods(request,
        onSuccess: (data) => hallPeriods(data.data), 
        onError: (e) => showPopupText(e.toString()),
         onComplete: () => isPeriodLoading(false));
  }

  Future getHallReservedPeriod(DateTime date) async{
    isPeriodLoading(true);
    resetPeriodEnabled();
    final request = HallsPeriodsRequest(
        id: args[0].id,
        branchId: user.selectedBranch!.id!,
        date: date);
   await HallsRepository().getHallReservedPeriods(request,
        onSuccess: (data) {
          hallReservedPeriods(data.data);
          for (int i = 0; i < (hallPeriods.length ?? 0); i++) {
            for (HallsPeriodsResponse reserved in hallReservedPeriods) {
              if (hallPeriods[i].id == reserved.id) {
                hallPeriods[i].enabled = false;
              }
            }
          }
          hallPeriods.assignAll(hallPeriods.toList());
        },
        onError: (e) => showPopupText(e.toString()),
        onComplete: () => isPeriodLoading(false));
  }

  resetPeriodEnabled() {
    for (int i = 0; i < hallPeriods.length; i++) {
      hallPeriods[i].enabled = true;
    }
    hallPeriods.assignAll(hallPeriods.toList());
  }
}
