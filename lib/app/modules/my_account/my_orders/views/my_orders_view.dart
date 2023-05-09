import 'package:easy_hotel/app/components/icon_button_widget.dart';
import 'package:easy_hotel/app/components/text_widget.dart';
import 'package:easy_hotel/app/core/utils/common.dart';
import 'package:easy_hotel/app/core/utils/user_manager.dart';
import 'package:easy_hotel/app/core/values/app_assets.dart';
import 'package:easy_hotel/app/core/values/app_colors.dart';
import 'package:easy_hotel/app/core/values/app_strings.dart';
import 'package:easy_hotel/app/data/provider/api_provider.dart';
import 'package:easy_hotel/app/modules/my_account/my_orders/controllers/my_orders_controller.dart';
import 'package:easy_hotel/app/modules/my_account/my_orders/views/widgets/order_widget.dart';
import 'package:easy_hotel/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const TextWidget(
          AppStrings.ordesr,
          weight: FontWeight.bold,
          size: 20,
        ),
        actions: [
          UnconstrainedBox(
            child: IconButtonWidget(
              icon: Icons.notifications,
              onPressed: () {
                // FavProductsManager().addProduct(controller.room!, context);
              },
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Common.getSpin(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < controller.orders.length; i++)
                  OrderWidget(
                      controller.orders[i].id!,
                      controller.orders[i].appId!,
                      controller.orders[i].branchId,
                      controller.orders[i].itemId ?? 0,
                      controller.orders[i].reviewId,
                      controller.orders[i].cost ??  0,
                      controller.orders[i].image ?? "",
                      controller.orders[i].name ?? "",
                      DateFormat('yyyy.MM.dd').format(
                              controller.orders[i].date ?? DateTime.now()) ??
                          "",
                      controller.orders[i].rate ?? 0)
              ],
            ),
          ),
        );
      }),
    );
  }
}
