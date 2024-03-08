import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:futuer_code/app/core/common/common.dart';
import 'package:futuer_code/app/core/extensions/enums.dart';
import 'package:futuer_code/app/core/utils/user_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/remote/repository/auth_repo/auth_repo.dart';
import '../../../../routes/app_pages.dart';
import '../views/add_image_view.dart';
import 'package:dio/dio.dart' as dio;

class RegisterPageController extends GetxController {
  RxDouble phoneProgress = 0.0.obs;
  RxDouble passProgress = 0.0.obs;
  RxDouble rePassProgress = 0.0.obs;
  RxDouble nameProgress = 0.0.obs;
  late FocusNode phoneNode;
  late FocusNode passNode;
  late FocusNode rePassNode;
  late FocusNode nameNode;
  late TextEditingController passController;
  late TextEditingController phoneController;
  late TextEditingController rePassController;
  late TextEditingController nameController;
  RxBool showPasswordValidator = false.obs;
  RxBool showPhoneValidator = false.obs;
  RxBool showRePasswordValidator = false.obs;
  RxBool showNameValidator = false.obs;
  RxBool showPassword = false.obs;
  RxBool showRePassword = false.obs;
  String rePassTextValidator = "";
  String phoneTextValidator = "";
  String passTextValidator = "";
  Rx<Uint8List> image = Uint8List(0).obs;
  final AuthRepo _repo = AuthRepo();
  Rx<LoadingType> loading = LoadingType.non.obs;

  @override
  void onInit() {
    passController = TextEditingController();
    phoneController = TextEditingController();
    rePassController = TextEditingController();
    nameController = TextEditingController();
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
    rePassNode = FocusNode()
      ..addListener(
        () {
          if (rePassNode.hasFocus) {
            showRePasswordValidator(false);
            startProgress(rePassProgress);
          } else {
            removeProgress(rePassProgress);
          }
        },
      );
    nameNode = FocusNode()
      ..addListener(
        () {
          if (nameNode.hasFocus) {
            showNameValidator(false);
            startProgress(nameProgress);
          } else {
            removeProgress(nameProgress);
          }
        },
      );
    super.onInit();
  }

  @override
  void onClose() {
    rePassNode.dispose();
    rePassController.dispose();
    nameController.dispose();
    nameNode.dispose();
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

  addImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: source);
    if (file != null) {
      image.value = await file.readAsBytes();
    }
    Get.back();
    update(["ADD_IMAGE"]);
  }

  toAddImage() {
    bool isValid = true;
    if (nameController.text.trim().isEmpty) {
      showNameValidator(true);
      startProgress(nameProgress);
      isValid = false;
    }
    if (phoneController.text.trim().isEmpty) {
      showPhoneValidator(true);
      phoneTextValidator = "ادخل رقم الهاتف";
      startProgress(phoneProgress);
      isValid = false;
    }
    if (phoneController.text.trim().length < 10) {
      showPhoneValidator(true);
      phoneTextValidator = "اجعل رقم الهاتف عشر خانات";
      startProgress(phoneProgress);
      isValid = false;
    }
    if (passController.text.trim().isEmpty) {
      showPasswordValidator(true);
      passTextValidator = "ادخل كلمة المرور";
      startProgress(passProgress);
      isValid = false;
    }
    if (passController.text.trim().length < 8) {
      showPasswordValidator(true);
      passTextValidator = "كلمة المرور يجب ان تكون اكبر من 8 محرف";
      startProgress(passProgress);
      isValid = false;
    }
    if (rePassController.text.trim().isEmpty) {
      showRePasswordValidator(true);
      rePassTextValidator = "اكد كلمة المرور";
      startProgress(rePassProgress);
      isValid = false;
    }
    if (rePassController.text.trim() != passController.text.trim()) {
      showRePasswordValidator(true);
      rePassTextValidator = "كلمة المرور غير متشابهة";
      startProgress(rePassProgress);
      isValid = false;
    }
    if (isValid) {
      Get.to(() => const AddImageView());
    }
  }

  onLoginTap() {
    if (image.value.isEmpty) {
      Common.showToast(message: "اضف صورة");
      return;
    }
    dio.FormData formData = dio.FormData.fromMap(
      {
        "fullname": nameController.text.trim(),
        "phone_number": phoneController.text.trim(),
        "password": passController.text.trim(),
        "password_confirmation": rePassController.text.trim(),
        "image": dio.MultipartFile.fromBytes(
          image.value,
          filename: "pic_${DateTime.now().toIso8601String()}",
        )
      },
    );
    _repo.register(
      formData: formData,
      beforeSend: () {
        loading(LoadingType.loading);
      },
      onError: (error) {
        Common.showToast(message: error.toString());
        loading(LoadingType.non);
      },
      onSuccess: (data) {
        loading(LoadingType.non);
        UserManager.manager.login(data.data);
        Get.offNamedUntil(Routes.MY_VEHICLES_PAGE, (route) => false);
      },
    );
  }
}
