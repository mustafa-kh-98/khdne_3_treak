import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futuer_code/app/core/utils/app_assets.dart';

import 'package:get/get.dart';

import '../controllers/splash_page_controller.dart';

class SplashPageView extends GetView<SplashPageController> {
  const SplashPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            PositionedDirectional(
              bottom: 0,
              child: SvgPicture.asset(
                AppAssets.SPLASH,
                fit: BoxFit.fill,
                width: Get.width,
              ),
            ),
            Positioned(
              top: Get.width/2,
              child: FadeTransition(
                opacity: controller.fadingAnimation!,
                child: SvgPicture.asset(
                  AppAssets.APP_LOGO,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
