import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components/text_widget.dart';
import '../../../../core/common/common.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class FirstIntro extends StatelessWidget {
  const FirstIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          SvgPicture.asset(AppAssets.LINE),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            children: [
              SizedBox(
                height: 70.h,
              ),
              Common.textWithUnderLine(
                title: "تطبيق خدني معك",
              ),
              SizedBox(
                height: 30.h,
              ),
              const TextWidget(
                "تطبيق لتقدر تلاقي بسهولة  سائق على طريقك لياخدك معو لتوصل بطريقة آمنة وسريعة ومريحة",
                textAlign: TextAlign.center,
                size: 16,
                height: 1.5,
                textColor: AppColors.TEXT_COLOR,
              ),
              SizedBox(
                height: 70.h,
              ),
              SizedBox(
                width: 220.0.w,
                height: 220.0.h,
                child:
                    SvgPicture.asset(AppAssets.ONBARDING_1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
