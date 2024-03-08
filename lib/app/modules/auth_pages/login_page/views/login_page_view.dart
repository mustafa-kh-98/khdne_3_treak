import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futuer_code/app/components/button_widget.dart';
import 'package:futuer_code/app/core/extensions/enums.dart';
import 'package:futuer_code/app/core/utils/app_assets.dart';
import 'package:futuer_code/app/core/utils/app_constants.dart';

import 'package:get/get.dart';

import '../../../../components/text_field_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/login_page_controller.dart';

class LoginPageView extends GetView<LoginPageController> {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              pinned: true,
              leading: const SizedBox.shrink(),
              expandedHeight: 120.h,
              surfaceTintColor: Colors.transparent,
              elevation: .1,
              shadowColor: AppColors.GRAY2,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: UnconstrainedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Hero(
                      tag: AppConstants.LOGO_HERO,
                      child: SvgPicture.asset(AppAssets.APP_LOGO, height: 40),
                    ),
                  ),
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
                  "تسجيل الدخول",
                  textColor: AppColors.TEXT_COLOR,
                  weight: FontWeight.bold,
                  size: 24,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(
                  () => TextFieldWidget(
                    focusNode: controller.phoneNode,
                    progress: controller.phoneProgress,
                    editingController: controller.phoneController,
                    hintText: "رقم الهاتف",
                    validatorText: "ادخل رقم الهاتف",
                    icon: AppAssets.PHONE_ICON,
                    inputType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    showValidation: controller.showPhoneValidator.value,
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
                    validatorText: "ادخل كلمة السر",
                    icon: AppAssets.PASS_ICON,
                    inputType: TextInputType.visiblePassword,
                    onSuffixClicked: () =>
                        controller.showPassword(!controller.showPassword.value),
                    suffixIcon: controller.showPassword.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    obscure: !controller.showPassword.value,
                    showValidation: controller.showPasswordValidator.value,
                    onFieldSubmitted: controller.onPassSubmitted,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextWidget(
                      "هل نسيت كلمة السر؟",
                      textColor: AppColors.TEXT_COLOR,
                      weight: FontWeight.w700,
                      size: 13,
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.h,
                ),
                Hero(
                  tag: AppConstants.BUTTON_HERO,
                  child: Obx(
                    () => ButtonWidget(
                      height: 55,
                      width: Get.width,
                      text: "تسجيل الدخول",
                      fontColor: Colors.white,
                      fontSize: 20,
                      radius: 30,
                      isLoading: controller.loading.value==LoadingType.loading,
                      onPressed: controller.onLoginTap,
                      buttonColor: AppColors.TEXT_COLOR,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: TextWidget(
                    "ليس لديك حساب؟",
                    size: 15,
                    textColor: AppColors.TEXT_COLOR,
                    weight: FontWeight.w500,
                    children: [
                      const TextWidget(" "),
                      TextWidget(
                        "إنشاء حساب",
                        textColor: AppColors.ORANG_COLOR,
                        weight: FontWeight.w700,
                        showUnderline: true,
                        onTap: () {
                          Get.toNamed(
                            Routes.REGISTER_PAGE,
                          );
                        },
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
