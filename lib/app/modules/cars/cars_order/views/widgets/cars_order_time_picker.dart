import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cars_order_controller.dart';

class CarsOrderTimePicker extends GetView<CarsOrderController> {
  const CarsOrderTimePicker({required this.time , Key? key}) : super(key: key);
  final bool time ;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: time ? controller.timeController.value : controller.dateController.value,
      maxLines: 1,
      readOnly: true,
      style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.date_range),
          hintText: "",
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 4),
      ),
      onTap: () async {
       !time ? await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2022),
          lastDate: DateTime(2030),
        ).then((value) {
          if (value != null) {
            controller.changeDate(value) ;
          }
        }):
           showTimePicker(
               context: context,
               initialTime: TimeOfDay.fromDateTime(DateTime.now()),
           ).then((value){
               if (value != null) {
         controller.changeTime(value) ;
       }}
           );

      },
    );
  }
}
