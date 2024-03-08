import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futuer_code/app/components/text_widget.dart';
import 'package:futuer_code/app/core/utils/app_assets.dart';
import 'package:futuer_code/app/core/utils/app_shadow.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../data/remote/models/vehicle_models/response/my_vehicle_response_dto.dart';
import '../../../../../routes/app_pages.dart';

class VehicleCard extends StatelessWidget {
  final MyVehiclesResponseDto vehicle;

  const VehicleCard({
    super.key,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.VEHICLE_INOF_PAGE,
          arguments: {
            "vehicle": vehicle,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.GRAY, width: .5),
          boxShadow: [AppShadow.homeShadow],
        ),
        child: Column(
          children: [
            Row(
              children: [
                TextWidget(
                  vehicle.model ?? "لا يوجد",
                  size: 14,
                  textColor: AppColors.TEXT_COLOR,
                ),
                const Spacer(),
                Container(
                  height: 50.w,
                  width: 50.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.ORANG_COLOR.withOpacity(.5),
                      width: .5,
                    ),
                    color: AppColors.GRAY,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.MOTTOR,
                    fit: BoxFit.none,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const TextWidget(
                  "سعر الكيلو:",
                  size: 14,
                  textColor: AppColors.TEXT_COLOR,
                ),
                const Spacer(),
                TextWidget(
                  " 1 ",
                  size: 14,
                  textColor: AppColors.TEXT_COLOR,
                  children: [
                    const TextWidget(
                      "كم",
                      size: 14,
                      textColor: AppColors.TEXT_COLOR,
                    ),
                    const TextWidget(
                      " / ",
                      size: 14,
                      textColor: AppColors.TEXT_COLOR,
                    ),
                    TextWidget(
                      "${vehicle.id}",
                      size: 14,
                      textColor: AppColors.TEXT_COLOR,
                    ),
                    const TextWidget(
                      " ل.س ",
                      size: 14,
                      textColor: AppColors.TEXT_COLOR,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const TextWidget(
                  "نسبة الشركة:",
                  size: 14,
                  textColor: AppColors.TEXT_COLOR,
                ),
                const Spacer(),
                TextWidget(
                  " 1 ",
                  size: 14,
                  textColor: AppColors.TEXT_COLOR,
                  children: [
                    const TextWidget(
                      "كم",
                      size: 14,
                      textColor: AppColors.TEXT_COLOR,
                    ),
                    const TextWidget(
                      " / ",
                      size: 14,
                      textColor: AppColors.TEXT_COLOR,
                    ),
                    TextWidget(
                      "${vehicle.id! ~/ 2}",
                      size: 14,
                      textColor: AppColors.TEXT_COLOR,
                    ),
                    const TextWidget(
                      " ل.س ",
                      size: 14,
                      textColor: AppColors.TEXT_COLOR,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
