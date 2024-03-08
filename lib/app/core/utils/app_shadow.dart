import 'package:flutter/material.dart';
import 'package:futuer_code/app/core/utils/app_colors.dart';

class AppShadow {
  static final BoxShadow homeShadow = BoxShadow(
    color: AppColors.GRAY2.withOpacity(.5),
    blurRadius: 7,
    spreadRadius: 1,
  );
}
