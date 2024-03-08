import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futuer_code/app/components/back_button.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:futuer_code/app/components/text_widget.dart';
import 'package:futuer_code/app/core/utils/app_assets.dart';
import 'package:futuer_code/app/core/utils/app_colors.dart';
import 'package:futuer_code/app/core/utils/translation/app_strings.dart';

import 'package:get/get.dart';

import '../controllers/onboarding_page_controller.dart';
import 'widgets/first.dart';

class OnboardingPageView extends GetView<OnboardingPageController> {
  const OnboardingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: AnimatedSwitcher(
            duration: const Duration(seconds: 250),
            child: Obx(
              () => controller.pageNumber.value == 1
                  ? const SizedBox.shrink()
                  : BackButtonWidget(
                      onTap: () {
                        controller.onBackTap();
                      },
                    ),
            ),
          ),
          leadingWidth: 70,
          actions: [
            TextButton(
              onPressed: controller.toLoginPage,
              child: Center(
                child: TextWidget(
                  AppStrings.SKIP.tr,
                  size: 15,
                  textColor: AppColors.TEXT_COLOR,
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            PositionedDirectional(
              top: 0,
              end: -10,
              width: Get.width,
              child: SvgPicture.asset(AppAssets.LINE),
            ),
            Navigator(
              key: controller.navigatorKey,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                fullscreenDialog: true,
                builder: (context) => const FirstIntro()
              ),
            ),
            PositionedDirectional(
              bottom: 30.h,
              child: Obx(
                () => CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 4.0,
                  animation: true,
                  restartAnimation: false,
                  animateFromLastPercent: true,
                  progressColor: AppColors.ORANG_COLOR,
                  percent: controller.pageIndicator.value,
                  backgroundColor: AppColors.PRIMARY_LIGHT_COLOR,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: AnimatedSwitcher(
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        child: child,
                      );
                    },
                    duration: const Duration(milliseconds: 250),
                    child: controller.pageNumber.value == 3
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(45),
                            child: Material(
                              color: AppColors.ORANG_COLOR,
                              child: InkWell(
                                splashColor:
                                    AppColors.ORANG_COLOR.withOpacity(.5),
                                onTap: controller.toLoginPage,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const UnconstrainedBox(
                                    child: TextWidget(
                                      "يلا",
                                      textColor: Colors.white,
                                      weight: FontWeight.bold,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                              child: Material(
                                color: AppColors.GRAY,
                                child: InkWell(
                                  splashColor:
                                      AppColors.ORANG_COLOR.withOpacity(.5),
                                  onTap: () {
                                    controller.onNextPageTap();
                                  },
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: UnconstrainedBox(
                                      child: SvgPicture.asset(
                                        AppAssets.ARROW_ICON,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//            PageView(
//               controller: controller.pageController,
//               physics: const NeverScrollableScrollPhysics(),
//               children: const [
//                 OnPageItem(
//                   isMedPage: false,
//                   onBoardTitle: "تطبيق خدني معك",
//                   onBoardSubtitle:
//                       "تطبيق لتقدر تلاقي بسهولة  سائق على طريقك لياخدك معو لتوصل بطريقة آمنة وسريعة ومريحة",
//                   svgLogo: AppAssets.ONBARDING_1,
//                 ),
//                 OnPageItem(
//                   isMedPage: true,
//                   onBoardTitle: "أشخاص لتاخدون ع طريقك",
//                   onBoardSubtitle:
//                       "بيخليك كسائق تقدر بسهولة توصل للأشخاص يلي على طريقك  بس حدد نقطة انطلاق ووصول والمناطق يلي رح تمر فيها .",
//                   svgLogo: AppAssets.ONBARDING_2,
//                 ),
//                 OnPageItem(
//                   isMedPage: false,
//                   onBoardTitle: " كيف بيتم هالشي ؟؟",
//                   onBoardSubtitle:
//                       "كل يلي عليك تسجل دخول وتتمتع بالخدمة يلي عم نقدملك ياها مع تطبيقنا المميز خدني معك .",
//                   svgLogo: AppAssets.ONBARDING_3,
//                 ),
//               ],
//             ),
