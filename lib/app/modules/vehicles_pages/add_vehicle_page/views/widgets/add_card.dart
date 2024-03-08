import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../components/collapsible.dart';
import '../../../../../components/text_widget.dart';
import '../../../../../core/utils/app_colors.dart';

class AddCard extends StatelessWidget {
  const AddCard({
    super.key,
    required this.title,
    required this.emptyTitle,
    required this.isEmpty,
    required this.desc,
    required this.svg,
    this.collapsibleValue = true,
    this.collapsibleWidget,
    this.onTap,
    this.showDivider = true,
  });

  final String title;
  final String emptyTitle;
  final String desc;
  final String svg;
  final bool collapsibleValue;
  final bool isEmpty;

  final Widget? collapsibleWidget;
  final void Function()? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          visualDensity: const VisualDensity(horizontal: -4),
          leading: SvgPicture.asset(svg),
          title: TextWidget(
            title,
            size: 16,
            weight: FontWeight.w500,
            textColor: AppColors.TEXT_COLOR,
          ),
          trailing: !isEmpty
              ? TextWidget(
                  desc,
                  size: 16,
                  weight: FontWeight.w500,
                  textColor: AppColors.ORANG_COLOR,
                )
              : TextWidget(
                  emptyTitle,
                  size: 12,
                  textColor: AppColors.TEXT_COLOR.withOpacity(.4),
                  children: const [TextWidget(" (اجباري) ")],
                ),
        ),
        Collapsible(
          collapsed: collapsibleValue,
          axis: CollapsibleAxis.vertical,
          maintainAnimation: true,
          child: Container(
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              child: collapsibleWidget ?? const SizedBox.shrink(),
            ),
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
}
