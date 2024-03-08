import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futuer_code/app/components/back_button.dart';

import 'package:get/get.dart';

import '../../../../components/button_widget.dart';
import '../../../../components/text_field_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../controllers/register_page_controller.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({Key? key}) : super(key: key);

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
                  "انشاء حساب",
                  textColor: AppColors.TEXT_COLOR,
                  weight: FontWeight.bold,
                  size: 24,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(
                  () => TextFieldWidget(
                    focusNode: controller.nameNode,
                    progress: controller.nameProgress,
                    editingController: controller.nameController,
                    validatorText: "ادخل الاسم",
                    showValidation: controller.showNameValidator.value,
                    hintText: "الاسم",
                    icon: AppAssets.PERSON_ICON,
                    inputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSaved: controller.onPhoneSubmitted,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => TextFieldWidget(
                    focusNode: controller.phoneNode,
                    progress: controller.phoneProgress,
                    editingController: controller.phoneController,
                    showValidation: controller.showPhoneValidator.value,
                    validatorText: controller.phoneTextValidator,
                    hintText: "رقم الهاتف",
                    icon: AppAssets.PHONE_ICON,
                    inputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    onSaved: controller.onPhoneSubmitted,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => TextFieldWidget(
                    focusNode: controller.passNode,
                    progress: controller.passProgress,
                    editingController: controller.passController,
                    hintText: "كلمة السر",
                    showValidation: controller.showPasswordValidator.value,
                    validatorText:controller.passTextValidator,
                    icon: AppAssets.PASS_ICON,
                    inputType: TextInputType.visiblePassword,
                    onSuffixClicked: () =>
                        controller.showPassword(!controller.showPassword.value),
                    suffixIcon: controller.showPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    obscure: !controller.showPassword.value,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(
                  () => TextFieldWidget(
                    focusNode: controller.rePassNode,
                    progress: controller.rePassProgress,
                    editingController: controller.rePassController,
                    validatorText: controller.rePassTextValidator,
                    showValidation: controller.showRePasswordValidator.value,
                    hintText: "تأكيد كلمة السر",
                    icon: AppAssets.PASS_ICON,
                    inputType: TextInputType.visiblePassword,
                    onSuffixClicked: () => controller
                        .showRePassword(!controller.showRePassword.value),
                    suffixIcon: controller.showRePassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    obscure: !controller.showRePassword.value,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Hero(
                  tag: AppConstants.BUTTON_HERO,
                  child: ButtonWidget(
                    height: 55,
                    width: Get.width,
                    text: "التالي",
                    fontColor: Colors.white,
                    fontSize: 20,
                    radius: 30,
                    onPressed: controller.toAddImage,
                    buttonColor: AppColors.TEXT_COLOR,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: TextWidget(
                    "لديك حساب؟",
                    size: 15,
                    textColor: AppColors.TEXT_COLOR,
                    weight: FontWeight.w500,
                    children: [
                      const TextWidget(" "),
                      TextWidget(
                        "تسجيل دخول",
                        textColor: AppColors.ORANG_COLOR,
                        weight: FontWeight.w700,
                        showUnderline: true,
                        onTap: () => Get.back(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: TextWidget(
                    "متابعتك تعني موافقتك على",
                    size: 15,
                    textAlign: TextAlign.center,
                    textColor: AppColors.TEXT_COLOR,
                    weight: FontWeight.w500,
                    children: [
                      const TextWidget(" "),
                      TextWidget(
                        "الشروط والاحكام وسياسة الخصوصية",
                        textColor: AppColors.ORANG_COLOR,
                        weight: FontWeight.w700,
                        showUnderline: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
