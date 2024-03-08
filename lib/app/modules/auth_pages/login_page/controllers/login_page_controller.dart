import 'dart:async';

import 'package:flutter/material.dart';
import 'package:futuer_code/app/core/common/common.dart';
import 'package:futuer_code/app/core/extensions/enums.dart';
import 'package:futuer_code/app/core/utils/user_manager.dart';
import 'package:futuer_code/app/data/remote/models/auth_models/request/login_request_dto.dart';
import 'package:get/get.dart';

import '../../../../data/remote/repository/auth_repo/auth_repo.dart';
import '../../../../routes/app_pages.dart';

class LoginPageController extends GetxController {
  RxDouble phoneProgress = 0.0.obs;
  RxDouble passProgress = 0.0.obs;

  late FocusNode phoneNode;
  late FocusNode passNode;

  late TextEditingController passController;
  late TextEditingController phoneController;

  RxBool showPassword = false.obs;
  RxBool showPasswordValidator = false.obs;
  RxBool showPhoneValidator = false.obs;
  final AuthRepo _repo = AuthRepo();
  Rx<LoadingType> loading = LoadingType.non.obs;

  @override
  void onInit() {
    passController = TextEditingController();
    phoneController = TextEditingController();

    phoneNode = FocusNode()
      ..addListener(
        () {
          if (phoneNode.hasFocus) {
            showPhoneValidator(false);
            startProgress(phoneProgress);
          } else {
            removeProgress(phoneProgress);
          }
        },
      );
    passNode = FocusNode()
      ..addListener(
        () {
          if (passNode.hasFocus) {
            showPasswordValidator(false);
            startProgress(passProgress);
          } else {
            removeProgress(passProgress);
          }
        },
      );
    super.onInit();
  }


  @override
  void onClose() {
    passNode.dispose();
    passController.dispose();
    phoneController.dispose();
    phoneNode.dispose();
    super.onClose();
  }

  void onPhoneSubmitted(
    String? v,
  ) {
    Get.focusScope!.requestFocus(passNode);
  }

  void onPassSubmitted(
    String v,
  ) {}

  void startProgress(RxDouble progress) {
    progress.value = 0.0;
    Timer? startTimer;
    startTimer = Timer.periodic(
      const Duration(milliseconds: 50),
      (_) {
        progress.value += 0.1;
        if (progress > 1.0) {
          startTimer!.cancel();
        }
      },
    );
  }

  void removeProgress(RxDouble progress) {
    progress.value = 1.0;
    Timer? removeTimer;
    removeTimer = Timer.periodic(
      const Duration(milliseconds: 50),
      (_) {
        progress.value -= 0.1;
        if (progress.value < 0.0) {
          removeTimer!.cancel();
        }
      },
    );
  }

  onLoginTap() {
    if (phoneController.text.trim().isEmpty) {
      showPhoneValidator(true);
      startProgress(phoneProgress);
    }
    if (passController.text.trim().isEmpty) {
      showPasswordValidator(true);
      startProgress(passProgress);
      return;
    }
    Get.focusScope!.unfocus();
    final loginRequestDto = LoginRequestDto(
      password: passController.text.trim(),
      phoneNumber: phoneController.text.trim(),
    );
    _repo.loginWithPhoneAndPass(
        loginRequestDto: loginRequestDto,
        beforeSend: () {
          loading(LoadingType.loading);
        },
        onSuccess: (data) {
          UserManager.manager.login(data.data);
          Get.offNamedUntil(Routes.MY_VEHICLES_PAGE, (route) => false);
          loading(LoadingType.non);
        },
        onError: (error) {
          loading(LoadingType.non);
          Common.showToast(message: error.toString());
        });
  }
}
