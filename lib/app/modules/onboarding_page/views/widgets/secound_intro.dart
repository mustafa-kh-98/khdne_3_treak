import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../components/text_widget.dart';
import '../../../../core/common/common.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';

class SecondIntro extends StatelessWidget {
  const SecondIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SvgPicture.asset(AppAssets.LINE1),
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            children: [
              SizedBox(
                height: 70.h,
              ),
              SizedBox(
                width: 220.0.w,
                height: 220.0.h,
                child: SvgPicture.asset(AppAssets.ONBARDING_2),
              ),
              SizedBox(
                height: 70.h,
              ),
              Common.textWithUnderLine(
                title: "أشخاص لتاخدون ع طريقك",
              ),
              SizedBox(
                height: 30.h,
              ),
              const TextWidget(
                "بيخليك كسائق تقدر بسهولة توصل للأشخاص يلي على طريقك  بس حدد نقطة انطلاق ووصول والمناطق يلي رح تمر فيها .",
                textAlign: TextAlign.center,
                size: 16,
                height: 1.5,
                textColor: AppColors.TEXT_COLOR,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
