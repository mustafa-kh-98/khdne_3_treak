import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:futuer_code/app/core/utils/app_assets.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:get/get.dart';

import '../../../../components/back_button.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_constants.dart';
import '../controllers/vehicle_inof_page_controller.dart';

class VehicleInofPageView extends GetView<VehicleInofPageController> {
  const VehicleInofPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              leadingWidth: 70,
              pinned: true,
              floating: false,
              leading: BackButtonWidget(onTap: () => Get.back()),
              expandedHeight: 120.h,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: false,
                title: TextWidget(
                  "معلوات المركبة",
                  size: 18,
                  textColor: AppColors.TEXT_COLOR,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            infoCard(
              title: "نوع المركبة",
              desc: controller.vehicle.type!.name ?? "غير معلوم",
              svg: AppAssets.CAR_TYPE,
            ),
            infoCard(
              title: "المودل",
              desc: controller.vehicle.model ?? "غير معلوم",
              svg: AppAssets.CAR_MODLE,
            ),
            infoCard(
              title: "لون المركبة",
              desc: controller.vehicle.color ?? "غير معلوم",
              svg: AppAssets.CAR_COLOR,
            ),
            infoCard(
              title: "رقم اللوحة",
              desc: controller.vehicle.boardNumber.toString() ?? "غير معلوم",
              svg: AppAssets.CAR_ID,
            ),
            infoCard(
              title: "سعر الكيلو",
              desc: "1 كم / 50 ل.س",
              svg: AppAssets.PRICE,
            ),
            infoCard(
              title: "نسبة ربح الشركة",
              desc: "1 كم / 50 ل.س",
              svg: AppAssets.PERCENT,
            ),
            SizedBox(
              height: 24.h,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextWidget(
                "صور المركبة",
                size: 16,
                weight: FontWeight.w700,
                textColor: AppColors.TEXT_COLOR,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return carPics(
                  index: index,
                  pic: controller.images[index].title,
                );
              },
              separatorBuilder: (_, __) {
                return SizedBox(
                  height: 10.h,
                );
              },
              itemCount: controller.images.length,
            ),
            SizedBox(
              height: 24.h,
            ),
            SizedBox(
              height: 180.h,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return picCard(
                      url: controller.images[index].url
                  );
                },
                separatorBuilder: (_, __) {
                  return SizedBox(
                    width: 12.w,
                  );
                },
                itemCount: controller.images.length,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
        const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Hero(
          tag: AppConstants.BUTTON_HERO,
          child: ButtonWidget(
            height: 55,
            width: Get.width,
            text: "اختيار مركبة",
            fontColor: Colors.white,
            fontSize: 20,
            radius: 30,
            onPressed: () {},
            buttonColor: AppColors.TEXT_COLOR,
          ),
        ),
      ),
    );
  }

  Widget infoCard({
    required String title,
    required String desc,
    required String svg,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          visualDensity: const VisualDensity(horizontal: -4),
          leading: SvgPicture.asset(svg),
          title: TextWidget(
            title,
            size: 16,
            weight: FontWeight.w500,
            textColor: AppColors.TEXT_COLOR,
          ),
          trailing: TextWidget(
            desc,
            size: 16,
            weight: FontWeight.w500,
            textColor: AppColors.ORANG_COLOR,
          ),
        ),
        if (showDivider)
          Divider(
            height: 10.h,
            indent: 48,
            thickness: .4,
            color: AppColors.GRAY3,
          ),
      ],
    );
  }

  carPics({
    required int index,
    required String pic,
  }) {
    return TextWidget(
      "${index + 1}",
      size: 14,
      weight: FontWeight.w500,
      textColor: AppColors.GRAY4,
      children: [
        const TextWidget(
          " - ",
        ),
        TextWidget(
          pic,
        ),
      ],
    );
  }

  picCard({
    required String url
  }) {
    return Stack(
      children: [
        SizedBox(
          height: 150.h,
          width: 150.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl:
              "${AppConstants.URL}$url",
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) {
                return const Icon(Icons.person);
              },
              placeholder: (_, __) =>
              const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 150.h,
          width: 150.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.GRAY, width: .5),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(.1),
                Colors.black.withOpacity(.0)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
