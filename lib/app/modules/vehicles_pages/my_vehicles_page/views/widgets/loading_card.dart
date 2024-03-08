import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../components/loading_animation.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_shadow.dart';

class LoadingCard extends StatelessWidget {
  const LoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.GRAY, width: .5),
        boxShadow: [
          AppShadow.homeShadow
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              LoadingAnimation(
                height: 10,
                width: 100.w,
                radius: 10,
              ),
              const Spacer(),
              LoadingAnimation(
                height: 40.w,
                width: 40.w,
                radius: 20.w,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              LoadingAnimation(
                height: 10,
                width: 110.w,
                radius: 10,
              ),
              const Spacer(),
              LoadingAnimation(
                height: 10,
                width: 200.w,
                radius: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              LoadingAnimation(
                height: 10,
                width: 110.w,
                radius: 10,
              ),
              const Spacer(),
              LoadingAnimation(
                height: 10,
                width: 200.w,
                radius: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
