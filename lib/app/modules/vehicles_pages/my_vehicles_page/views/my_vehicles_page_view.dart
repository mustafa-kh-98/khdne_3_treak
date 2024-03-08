import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futuer_code/app/components/back_button.dart';
import 'package:futuer_code/app/components/text_widget.dart';
import 'package:futuer_code/app/core/extensions/enums.dart';
import 'package:futuer_code/app/modules/vehicles_pages/my_vehicles_page/views/widgets/loading_card.dart';
import 'package:futuer_code/app/routes/app_pages.dart';

import 'package:get/get.dart';

import '../../../../components/button_widget.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../controllers/my_vehicles_page_controller.dart';
import 'widgets/vehicle_card.dart';

class MyVehiclesPageView extends GetView<MyVehiclesPageController> {
  const MyVehiclesPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: controller.scrollController,
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              leadingWidth: 70,
              pinned: true,
              floating: false,
              leading: BackButtonWidget(onTap: () {}),
              expandedHeight: 120.h,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: false,
                title: TextWidget(
                  "مركباتي",
                  size: 18,
                  textColor: AppColors.TEXT_COLOR,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ];
        },
        body: Obx(
          () {
            if (controller.loading.value == LoadingType.loading) {
              return ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemBuilder: (context, index) {
                  return const LoadingCard();
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: 15,
              );
            } else if (controller.myVehicle.isEmpty) {
              return SizedBox(
                width: Get.width,
                height: Get.height,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      "لا يوجدي مركبات",
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              );
            } else {
              return ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                itemBuilder: (context, index) {
                  return VehicleCard(
                    vehicle: controller.myVehicle[index],
                  );
                },
                separatorBuilder: (_, __) {
                  return const SizedBox(
                    height: 15,
                  );
                },
                itemCount: controller.myVehicle.length,
              );
            }
          },
        ),
      ),
      bottomNavigationBar: AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0))
              .animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        duration: const Duration(milliseconds: 250),
        child: Obx(
          () => controller.loading.value == LoadingType.loading
              ? const SizedBox(
                  key: Key("1"),
                )
              : Padding(
                  key: const Key("2"),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 10),
                  child: Hero(
                    tag: AppConstants.BUTTON_HERO,
                    child: ButtonWidget(
                      height: 55,
                      width: Get.width,
                      text: "اضف مركبة",
                      fontColor: Colors.white,
                      fontSize: 20,
                      radius: 30,
                      onPressed: () {
                        Get.toNamed(Routes.ADD_VEHICLE_PAGE);
                      },
                      buttonColor: AppColors.TEXT_COLOR,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
