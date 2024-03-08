import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futuer_code/app/core/common/common.dart';
import 'package:futuer_code/app/core/extensions/enums.dart';

import 'package:get/get.dart';

import '../../../../components/back_button.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/add_vehicle_page_controller.dart';
import 'widgets/add_card.dart';
import 'widgets/iamges_add.dart';

class AddVehiclePageView extends GetView<AddVehiclePageController> {
  const AddVehiclePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Common.openDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              const TextWidget(
                "هل تريد الغاء الاضافة؟",
                textColor: AppColors.TEXT_COLOR,
                size: 24,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ButtonWidget(
                  width: Get.width,
                  text: "نعم",
                  radius: 25,
                  fontColor: Colors.white,
                  isLoading: false,
                  buttonColor: AppColors.TEXT_COLOR,
                  onPressed: () => Get.offNamedUntil(
                      Routes.MY_VEHICLES_PAGE, (route) => false),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );

        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              SliverAppBar(
                leadingWidth: 70,
                pinned: true,
                floating: false,
                leading: BackButtonWidget(
                  onTap: () {
                    Common.openDialog(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const TextWidget(
                            "هل تريد الغاء الاضافة؟",
                            textColor: AppColors.TEXT_COLOR,
                            size: 24,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ButtonWidget(
                              width: Get.width,
                              text: "نعم",
                              radius: 25,
                              fontColor: Colors.white,
                              isLoading: false,
                              buttonColor: AppColors.TEXT_COLOR,
                              onPressed: () => Get.offNamedUntil(
                                  Routes.MY_VEHICLES_PAGE, (route) => false),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                expandedHeight: 120.h,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: false,
                  title: TextWidget(
                    "اضافة مركبة",
                    size: 18,
                    textColor: AppColors.TEXT_COLOR,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ];
          },
          body: ListView(
            children: [
              Obx(
                () => AddCard(
                  title: "نوع المركبة",
                  emptyTitle: "نوع المركبة",
                  isEmpty: controller.carTypeSelected.isEmpty,
                  desc: controller.carTypeSelected.value,
                  onTap: controller.openTypeCarCollapsible,
                  collapsibleValue: controller.openCarType.value,
                  collapsibleWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...controller.carTypes.map((entry) {
                        return Obx(
                          () => RadioListTile<String>(
                            title: TextWidget(
                              entry.name!,
                              size: 16,
                              weight: FontWeight.w500,
                              textColor: AppColors.TEXT_COLOR,
                            ),
                            value: entry.id.toString(),
                            visualDensity: const VisualDensity(
                                vertical: -4, horizontal: -4),
                            activeColor: AppColors.ORANG_COLOR,
                            groupValue: controller.selectedCarType.value,
                            onChanged: controller.setSelectedCarType,
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                  svg: AppAssets.CAR_TYPE,
                ),
              ),
              Obx(
                () => AddCard(
                  title: "المودل",
                  emptyTitle: "مودل المركبة",
                  desc: controller.carModelSelected.value,
                  isEmpty: controller.carModelSelected.isEmpty,
                  onTap: () {
                    _openSheet(
                      carInfoType: CarInfoType.model,
                      type: TextInputType.text,
                      svg: AppAssets.CAR_MODLE,
                      title: "موديل مركبتك",
                      textController: controller.modelController,
                      hint: "المودل",
                    );
                  },
                  svg: AppAssets.CAR_MODLE,
                ),
              ),
              Obx(
                () => AddCard(
                  title: "لون المركبة",
                  emptyTitle: "لون المركبة",
                  desc: controller.carColorSelected.value,
                  isEmpty: controller.carColorSelected.isEmpty,
                  svg: AppAssets.CAR_COLOR,
                  onTap: controller.openColorCarCollapsible,
                  collapsibleValue: controller.openCarColor.value,
                  collapsibleWidget: SizedBox(
                    height: 60,
                    width: Get.width,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = controller.carColor[index];

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Material(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                controller.setSelectedCarColor(item.id);
                              },
                              child: GetBuilder<AddVehiclePageController>(
                                id: "COLOR_UPDATE",
                                builder: (colorController) {
                                  final Color colorBorder =
                                      controller.selectedCarColor.value ==
                                              item.id
                                          ? item.color
                                          : Colors.white;
                                  return Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      boxShadow: const [
                                        BoxShadow(
                                            color: AppColors.GRAY,
                                            blurRadius: 2,
                                            spreadRadius: 2)
                                      ],
                                      border: Border.all(
                                        color: colorBorder,
                                        width: 2,
                                      ),
                                    ),
                                    child: UnconstrainedBox(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: item.color,
                                          border: Border.all(
                                              color: Colors.transparent,
                                              width: 1),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) {
                        return const SizedBox(
                          width: 12,
                        );
                      },
                      itemCount: controller.carColor.length,
                    ),
                  ),
                ),
              ),
              Obx(
                () => AddCard(
                  title: "رقم اللوحة",
                  desc: controller.carIdSelected.value,
                  emptyTitle: "رقم اللوحة",
                  isEmpty: controller.carIdSelected.isEmpty,
                  svg: AppAssets.CAR_ID,
                  onTap: () {
                    _openSheet(
                      type: TextInputType.number,
                      carInfoType: CarInfoType.idCard,
                      svg: AppAssets.CAR_ID,
                      title: "رقم اللوحة",
                      textController: controller.carIdController,
                      hint: "لوحتك",
                    );
                  },
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextWidget(
                  "صور المركبة",
                  size: 16,
                  weight: FontWeight.w700,
                  textColor: AppColors.TEXT_COLOR,
                  children: [
                    TextWidget(
                      " (اضف الصور بالتريب التالي) ",
                      size: 12,
                      textColor: AppColors.TEXT_COLOR.withOpacity(.4),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return carPics(
                    index: index,
                    pic: controller.pics[index],
                  );
                },
                separatorBuilder: (_, __) {
                  return SizedBox(
                    height: 10.h,
                  );
                },
                itemCount: controller.pics.length,
              ),
              SizedBox(
                height: 10.h,
              ),
              GetBuilder<AddVehiclePageController>(
                id: "ADD_IMAGE",
                builder: (_) {
                  return imageAndAddView();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: Hero(
            tag: AppConstants.BUTTON_HERO,
            child: Obx(
              () => ButtonWidget(
                height: 55,
                width: Get.width,
                text: "اضف مركبة",
                fontColor: Colors.white,
                fontSize: 20,
                radius: 30,
                isLoading: controller.loading.value == LoadingType.loading,
                onPressed: controller.addNewCar,
                buttonColor: AppColors.TEXT_COLOR,
              ),
            ),
          ),
        ),
      ),
    );
  }

  imageAndAddView() {
    List<Widget> content = [];
    if (controller.images.length <= 4) {
      content.add(
        UnconstrainedBox(
          child: InkWell(
            onTap: controller.addImage,
            child: Container(
              height: 150.h,
              width: 150.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.GRAY, width: .5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.13),
                    blurRadius: 7,
                    spreadRadius: 1,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.13),
                          blurRadius: 7,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: UnconstrainedBox(
                      child: SvgPicture.asset(AppAssets.ADD),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextWidget(
                    "اضف صورة",
                    size: 16,
                    textAlign: TextAlign.center,
                    weight: FontWeight.w700,
                    textColor: AppColors.TEXT_COLOR,
                    children: [
                      TextWidget(
                        " ${controller.pics[controller.images.length]} ",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    for (var element in controller.images) {
      content.add(
        SizedBox(
          width: 12.h,
        ),
      );
      content.add(
        ImageCard(
          image: element,
        ),
      );
    }
    return SizedBox(
      height: 180.h,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        children: content,
      ),
    );
  }

  carPics({
    required int index,
    required String pic,
  }) {
    return TextWidget(
      "${index + 1}",
      size: 14,
      weight: FontWeight.w500,
      textColor: AppColors.GRAY4,
      children: [
        const TextWidget(
          " - ",
        ),
        TextWidget(
          pic,
        ),
      ],
    );
  }

  _openSheet({
    required String title,
    required String svg,
    required TextInputType type,
    required String hint,
    required TextEditingController textController,
    required CarInfoType carInfoType,
  }) {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 7,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)),
                  height: 4,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                title,
                size: 22,
                textColor: AppColors.TEXT_COLOR,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                child: TextFormField(
                  keyboardType: type,
                  cursorColor: AppColors.ORANG_COLOR,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                  autofocus: false,
                  textAlign: TextAlign.start,
                  controller: textController,
                  enabled: true,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withOpacity(.1),
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(.1)),
                        borderRadius: BorderRadius.circular(30)),
                    hintText: hint,
                    helperStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    contentPadding: const EdgeInsets.only(
                        left: 15, bottom: 0, top: 0, right: 15),
                    prefixIcon: UnconstrainedBox(
                      child: SvgPicture.asset(svg),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonWidget(
                width: Get.width,
                text: "تأكيد",
                radius: 25,
                fontColor: Colors.white,
                isLoading: false,
                buttonColor: AppColors.TEXT_COLOR,
                onPressed: () {
                  controller.setSelectedCarIdAndModel(
                    controller: textController,
                    carInfoType: carInfoType,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
