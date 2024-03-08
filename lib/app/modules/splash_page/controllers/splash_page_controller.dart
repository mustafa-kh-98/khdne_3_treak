import 'package:flutter/material.dart';
import 'package:futuer_code/app/core/utils/user_manager.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double>? fadingAnimation;

  @override
  void onInit() {
    animation();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void animation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    fadingAnimation =
        Tween<double>(begin: .2, end: 1).animate(animationController);

    animationController.repeat(reverse: true);
    nextPage();
  }

  void nextPage() {
    bool hasToken = UserManager.manager.isLoggedIn;
    bool hasShowIntro = UserManager.manager.isShowIntro;
    Future.delayed(
      const Duration(seconds: 5),
      () {
        hasShowIntro
            ? hasToken
                ? Get.offNamedUntil(
                    Routes.MY_VEHICLES_PAGE,
                    (route) => false,
                  )
                : Get.offNamedUntil(Routes.LOGIN_PAGE, (route) => false)
            : Get.offNamedUntil(Routes.ONBOARDING_PAGE, (route) => false);
      },
    );
  }
}
