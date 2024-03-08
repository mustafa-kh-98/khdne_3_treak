import 'package:flutter/material.dart';
import 'package:futuer_code/app/core/utils/app_storage.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../views/widgets/first.dart';
import '../views/widgets/secound_intro.dart';
import '../views/widgets/third.dart';

class OnboardingPageController extends GetxController {
  RxDouble pageIndicator = .33.obs;
  RxInt pageNumber = 1.obs;
  final navigatorKey = GlobalKey<NavigatorState>();

  List intros = [const FirstIntro(), const SecondIntro(), const ThirdIntro()];


  Future<void> push(Widget route) {
    return navigatorKey.currentState!.push(
      PageRouteBuilder(
        fullscreenDialog: true,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = 0.0;
          const end = 1.0;
          var curve = Curves.ease;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var opacityAnimation = animation.drive(tween);
          return FadeTransition(
            opacity: opacityAnimation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return route;
        },
      ),
    );
  }

  onNextPageTap() {
    if (pageNumber.value == 3) {
      return;
    } else {
      pageNumber.value++;
      push(intros[pageNumber.value - 1]);
      pageIndicator(pageIndicator.value + .33);
    }
  }

  onBackTap() {
    if (pageNumber.value == 1) {
      return;
    } else {
      pageNumber.value--;
      push(intros[pageNumber.value - 1]);
      pageIndicator(pageIndicator.value - .33);
    }
  }

  Future<bool> onWillPop() async {
    onBackTap();
    return false;
  }

  toLoginPage() {
    AppStorage.write(AppStorage.IS_SHOW_INTRO, true);
    Get.offNamedUntil(
      Routes.LOGIN_PAGE,
      (route) => false,
    );
  }
}
