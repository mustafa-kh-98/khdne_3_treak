import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;

import '../../components/text_widget.dart';
import '../utils/app_colors.dart';
import '../utils/theme/app_theme.dart';

abstract class Common {
  static void initStatusBars({Color? color, bool isDark = false}) {
    if (color == null) {
      if (AppTheme.isDark) {
        color = Colors.grey[900]!;
        isDark = true;
      } else {
        color = Colors.transparent;
      }
    }

    FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    FlutterStatusbarcolor.setNavigationBarColor(
        AppTheme.isDark ? color : Colors.grey.withOpacity(0.01));
    FlutterStatusbarcolor.setStatusBarWhiteForeground(isDark);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(isDark);
  }

  static showToast({required String message}) {
    FToast fToast;
    fToast = FToast();
    // fToast.removeQueuedCustomToasts();
    fToast.init(Get.overlayContext!);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: AppColors.TEXT_COLOR,
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset.zero,
              spreadRadius: 1,
              blurRadius: 5)
        ],
      ),
      child: TextWidget(message.tr,
          textColor: Colors.white, textAlign: TextAlign.center),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration:  const Duration(seconds:3),
    );
  }
  static Future<Future> openDialog({
    double width = 400,
    double maxHeight = 500,
    double opacity = 0.9,
    double circular = 16,
    bool barrierDismissible = true,
    Curve transitionCurve = Curves.easeInOut,
    Color barrierColor = Colors.transparent,
    dynamic child,
  }) async {
    return Get.dialog(
      Center(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 6,
            sigmaY: 6,
          ),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: width,
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              constraints: BoxConstraints(maxHeight: maxHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(circular),
                color: Get.theme.cardColor.withOpacity(opacity),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff33000000),
                    blurRadius: 20,
                  )
                ],
              ),
              child: child,
            ),
          ),
        ),
      ),
      barrierColor: barrierColor,
      barrierDismissible: barrierDismissible,
      transitionCurve: transitionCurve,
    );
  }
 static Widget textWithUnderLine({
    required String title,
  }) {
    final Size size = _textSize(
      title,
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    );
    return SizedBox(
      height: size.height + 5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PositionedDirectional(
            bottom: 2,
            start: 10,
            child: Container(
              height: 15,
              width: size.width,
              decoration: BoxDecoration(
                color: AppColors.ORANG_COLOR.withOpacity(.5),
              ),
            ),
          ),
          PositionedDirectional(
            start: 0,
            child: TextWidget(
              title,
              textColor: AppColors.TEXT_COLOR,
              weight: FontWeight.bold,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  static Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
