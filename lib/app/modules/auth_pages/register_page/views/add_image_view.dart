import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futuer_code/app/components/back_button.dart';
import 'package:futuer_code/app/core/extensions/enums.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/button_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/app_shadow.dart';
import '../controllers/register_page_controller.dart';

class AddImageView extends GetView<RegisterPageController> {
  const AddImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              pinned: true,
              leading: BackButtonWidget(
                onTap: () => Get.back(),
              ),
              leadingWidth: 70,
              expandedHeight: 120.h,
              surfaceTintColor: Colors.transparent,
              elevation: .1,
              shadowColor: AppColors.GRAY2,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Column(
                  children: [
                    const Spacer(),
                    Center(
                      child: UnconstrainedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Hero(
                            tag: AppConstants.LOGO_HERO,
                            child: SvgPicture.asset(AppAssets.APP_LOGO,
                                height: 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: SvgPicture.asset(
                AppAssets.APP_BACKGROUND,
              ),
            ),
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 30.h,
                ),
                const TextWidget(
                  "اضف صورة",
                  textColor: AppColors.TEXT_COLOR,
                  weight: FontWeight.bold,
                  size: 24,
                ),
                SizedBox(
                  height: 5.h,
                ),
                const TextWidget(
                  "اجعل صورتك واضحة",
                  textColor: AppColors.TEXT_COLOR,
                  weight: FontWeight.w500,
                  size: 18,
                ),
                SizedBox(
                  height: 50.h,
                ),
                GetBuilder<RegisterPageController>(
                  id: "ADD_IMAGE",
                  builder: (_) {
                    return Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Container(
                            width: 250.h,
                            height: 250.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                AppShadow.homeShadow,
                              ],
                              shape: BoxShape.circle,
                              image: controller.image.value.isEmpty
                                  ? null
                                  : DecorationImage(
                                      image: MemoryImage(
                                        controller.image.value,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: controller.image.value.isEmpty
                                ? UnconstrainedBox(
                                    child: SvgPicture.asset(
                                      AppAssets.PERSON_PIC,
                                    ),
                                  )
                                : null,
                          ),
                          PositionedDirectional(
                            bottom: 10.h,
                            start: 20.w,
                            child: InkWell(
                              onTap: _openSheet,
                              child: Container(
                                width: 50.h,
                                height: 50.h,
                                decoration: const BoxDecoration(
                                  color: AppColors.ORANG_COLOR,
                                  shape: BoxShape.circle,
                                ),
                                child: UnconstrainedBox(
                                  child: SvgPicture.asset(
                                    AppAssets.ADD,
                                    color: Colors.white,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
            PositionedDirectional(
              bottom: 30,
              end: 10,
              start: 10,
              child: Padding(
                key: const Key("2"),
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 20, top: 10),
                child: Obx(
                  () => Hero(
                    tag: AppConstants.BUTTON_HERO,
                    child: ButtonWidget(
                      height: 55,
                      width: Get.width,
                      text: "انشاء حساب",
                      fontColor: Colors.white,
                      fontSize: 20,
                      radius: 30,
                      isLoading:
                          controller.loading.value == LoadingType.loading,
                      onPressed: controller.onLoginTap,
                      buttonColor: AppColors.TEXT_COLOR,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openSheet() {
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
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                  color: AppColors.ORANG_COLOR,
                ),
                title: const TextWidget(
                  "من الكاميرا",
                  size: 18,
                  textColor: AppColors.TEXT_COLOR,
                  weight: FontWeight.w700,
                ),
                trailing: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColors.TEXT_COLOR,
                ),
                onTap: () {
                  controller.addImage(ImageSource.camera);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(
                  Icons.image_search_outlined,
                  color: AppColors.ORANG_COLOR,
                ),
                title: const TextWidget(
                  "من المعرض",
                  size: 18,
                  textColor: AppColors.TEXT_COLOR,
                  weight: FontWeight.w700,
                ),
                trailing: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: AppColors.TEXT_COLOR,
                ),
                onTap: () {
                  controller.addImage(ImageSource.gallery);
                },
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
