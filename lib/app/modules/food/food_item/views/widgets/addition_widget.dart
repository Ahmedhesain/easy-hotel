import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../components/additions_dialog.dart';
import '../../../../../components/icon_button_widget.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/values/app_strings.dart';
import '../../controllers/food_item_controller.dart';

class AdditionWidget extends GetView<FoodItemController> {
  const AdditionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size ;
    return Obx(() {
      return controller.pro.value != null && controller.pro.value!.addititonsList!.isNotEmpty ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TextWidget(
                AppStrings.additions,
                weight: FontWeight.bold,
                children: [TextWidget(":")],
              ),
              const Spacer(),
              IconButtonWidget(
                icon: Icons.add,
                onPressed: () => Get.dialog(AdditionsDialog()),
                padding: EdgeInsets.zero,
                color: AppColors.restaurantThirdColor,
              )
            ],
          ),
          const Divider(height: 5),
          SizedBox(
            height: size.height * 0.06 * controller.selectedAdditions.length,
            child: ListView.builder(
              itemBuilder: (context , i){
               final  add = controller.selectedAdditions[i];
                return SizedBox(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: TextWidget(add.name! , weight: FontWeight.bold,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: TextWidget((add.price ?? AppStrings.free).toString(), weight: FontWeight.bold,children: const [TextWidget(AppStrings.LE)],)),
                      ),
                        IconButton(
                            onPressed: ()=> controller.changeAddition(add),
                            icon:const Icon(Icons.remove , color: Colors.red,)),
                    ],
                  ),
                );
              },
              itemCount: controller.selectedAdditions.length,
            ),
          )
        ],
      ):const SizedBox.shrink();
    });
  }
}
