import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../core/utils/app_colors.dart';
import 'icon_button_widget.dart';
import 'text_widget.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    required this.focusNode,
    required this.progress,
    required this.editingController,
    required this.hintText,
    required this.icon,
    required this.showValidation ,
    required this.validatorText ,
    this.onFieldSubmitted,
    this.textInputAction,
    this.onSaved,
    this.inputType,
    this.suffixIcon,
    this.onSuffixClicked,
    this.maxLength,
    this.obscure = false,
    Key? key,
  }) : super(key: key);
  final FocusNode focusNode;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final TextEditingController editingController;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final RxDouble progress;
  final String hintText;
  final String validatorText;
  final String icon;
  final IconData? suffixIcon;
  final Function()? onSuffixClicked;
  final bool obscure;
  final bool showValidation;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    final sufIcon = suffixIcon != null
        ? SizedBox(
            height: 40,
            width: 40,
            child: IconButtonWidget(
              icon: suffixIcon,
              // color: AppColors.ORANG_COLOR,
              iconColor: AppColors.GRAY3,
              onPressed: onSuffixClicked,
            ),
          )
        : null;
    return Column(
      children: [
        TextFormField(
          textInputAction: textInputAction ?? TextInputAction.done,
          focusNode: focusNode,
          cursorColor: AppColors.ORANG_COLOR,
          keyboardType: inputType ?? TextInputType.text,
          controller: editingController,
          obscureText: obscure,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          maxLength:maxLength ,
          decoration: InputDecoration(
            prefixIcon: UnconstrainedBox(
              child: SvgPicture.asset(
                icon,
              ),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.TEXT_COLOR,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: sufIcon,
          ),
        ),
        if (showValidation)
          Column(
            children: [
              Obx(
                () => LinearProgressIndicator(
                  minHeight: 1.5,
                  color:Colors.red,
                  backgroundColor: AppColors.GRAY2,
                  value: progress.value,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    validatorText,
                    textColor: Colors.red,
                    weight: FontWeight.w700,
                    size: 13,
                  ),
                ],
              ),
            ],
          ),
        if (!showValidation)
          Obx(
            () => LinearProgressIndicator(
              minHeight: 1.5,
              color: AppColors.ORANG_COLOR,
              backgroundColor: AppColors.GRAY2,
              value: progress.value,
            ),
          ),
      ],
    );
  }
}
