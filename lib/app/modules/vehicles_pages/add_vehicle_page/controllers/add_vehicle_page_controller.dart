import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:futuer_code/app/core/common/common.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../components/button_widget.dart';
import '../../../../components/text_widget.dart';
import '../../../../core/extensions/enums.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_storage.dart';
import '../../../../core/utils/entity/car_color_entity.dart';
import '../../../../data/remote/models/vehicle_models/response/my_vehicle_response_dto.dart';
import '../../../../data/remote/repository/vehicle_repo/vehicle_repo.dart';
import '../../../../routes/app_pages.dart';

enum CarInfoType { model, idCard }

class AddVehiclePageController extends GetxController {
  RxBool openCarType = true.obs;
  RxBool openCarColor = true.obs;
  RxString selectedCarType = "".obs;
  late RxString selectedCarColor;
  late TextEditingController modelController;
  late TextEditingController carIdController;
  List<String> pics = [
    "الميكانيك",
    "المركبة",
    "اللوحة",
    "الهوية الشخصية",
    "الوكالة او التفويض"
  ];

  List<Uint8List> images = [];
  List<CarColorEntity> carColor = [
    CarColorEntity(id: "1", color: Colors.black, colorTitle: "اسود"),
    CarColorEntity(id: "2", color: Colors.white, colorTitle: "ابيض"),
    CarColorEntity(id: "3", color: Colors.red, colorTitle: "احمر"),
    CarColorEntity(id: "4", color: Colors.blueAccent, colorTitle: "ازرق"),
    CarColorEntity(id: "5", color: Colors.grey, colorTitle: "رمادي"),
    CarColorEntity(id: "6", color: Colors.yellow, colorTitle: "اصفر"),
  ];

  RxString carTypeSelected = "".obs;
  RxString carColorSelected = "".obs;
  RxString carModelSelected = "".obs;
  RxString carIdSelected = "".obs;
  final VehicleRepo _repo = VehicleRepo();
  RxList<Type> carTypes = <Type>[].obs;
  Rx<LoadingType> loading = LoadingType.non.obs;

  @override
  void onInit() {
    _getCarTypes();
    selectedCarColor = carColor.first.id.obs;
    modelController = TextEditingController();
    carIdController = TextEditingController();
    super.onInit();
  }


  @override
  void onClose() {
    modelController.dispose();
    carIdController.dispose();
    super.onClose();
  }

  openTypeCarCollapsible() {
    openCarType(!openCarType.value);
  }

  openColorCarCollapsible() {
    openCarColor(!openCarColor.value);
  }

  void setSelectedCarType(String? newValue) {
    if (newValue == null) {
      return;
    }
    openCarType.value = !openCarType.value;
    selectedCarType.value = newValue;
    carTypeSelected(
        carTypes.where((p0) => p0.id.toString() == newValue).single.name);
  }

  void setSelectedCarColor(String id) {
    openCarColor(!openCarColor.value);
    selectedCarColor(id);
    carColorSelected(
        carColor.where((element) => element.id == id).single.colorTitle);
    update(["COLOR_UPDATE"]);
  }

  void setSelectedCarIdAndModel({
    required TextEditingController controller,
    required CarInfoType carInfoType,
  }) {
    Get.back();
    if (carInfoType == CarInfoType.model) {
      carModelSelected(controller.text.trim());
    } else {
      carIdSelected(controller.text.trim());
    }
  }

  addImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      images.add(await image.readAsBytes());
    }
    update(["ADD_IMAGE"]);
  }

  _getCarTypes() {
    final List<dynamic> data = AppStorage.read(AppStorage.CARS_TYPE) ?? [];
    if (data.isNotEmpty) {
      List<Type> types = [];
      types.addAll(data.map((e) => Type.fromJson(e)).toList());
      carTypes.value = [...types];
      return;
    }
    _repo.getMyVehiclesType(
      beforeSend: () {},
      onSuccess: (data) {
        carTypes.value = [...data.data];
        selectedCarType("");
      },
      onError: (error) {
        Common.showToast(message: error.toString());
      },
    );
  }

  addNewCar() async {
    bool isValid = true;
    if (carTypeSelected.value.isEmpty) {
      Common.showToast(message: "ادخل نوع المركبة");
      isValid = false;
    }
    if (carModelSelected.value.isEmpty) {
      Common.showToast(message: "ادخل موديل المركبة");
      isValid = false;
    }
    if (carColorSelected.value.isEmpty) {
      Common.showToast(message: "ادخل لون المركبة");
      isValid = false;
    }
    if (carIdSelected.value.isEmpty) {
      Common.showToast(message: "ادخل رقم الوحة للمركبة");
      isValid = false;
    }
    if (images.length < 4) {
      Common.showToast(message: "ادخل باقي الصور");
      isValid = false;
    }
    if (!isValid) return;

    dio.FormData formData = dio.FormData.fromMap({
      "vehicle_type_id": int.parse(selectedCarType.value),
      "board_number":
          int.parse(carIdSelected.value.replaceAll(RegExp(r'[^0-9]'), '')),
      "model": carModelSelected.value,
      "color": carColorSelected.value,
      "vehicle_image": dio.MultipartFile.fromBytes(
        images[1],
        filename: "vehicle_image${DateTime.now().toIso8601String()}",
      ),
      "board_image": dio.MultipartFile.fromBytes(
        images[2],
        filename: "board_image${DateTime.now().toIso8601String()}",
      ),
      "id_image": dio.MultipartFile.fromBytes(
        images[3],
        filename: "id_image${DateTime.now().toIso8601String()}",
      ),
      "mechanic_image": dio.MultipartFile.fromBytes(
        images[0],
        filename: "mechanic_image_${DateTime.now().toIso8601String()}",
      ),
      "delegate_image": dio.MultipartFile.fromBytes(
        images[4],
        filename: "delegate_image${DateTime.now().toIso8601String()}",
      ),
    });

    _repo.addNewVehicle(
      data: formData,
      beforeSend: () {
        loading(LoadingType.loading);
      },
      onSuccess: (data) {
        Common.openDialog(
          barrierDismissible: false,
          child: WillPopScope(
            onWillPop: () async {
              Get.offNamedUntil(Routes.MY_VEHICLES_PAGE, (route) => false);
              return false;
            },
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  SvgPicture.asset(AppAssets.DONE),
                  SizedBox(
                    height: 20.h,
                  ),
                  const TextWidget(
                    "طلبك قيد المراجعة سيتم اعلامك بالنتيجة",
                    size: 18,
                    textColor: AppColors.TEXT_COLOR,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ButtonWidget(
                      width: Get.width,
                      text: "موافق",
                      radius: 25,
                      fontColor: Colors.white,
                      isLoading: false,
                      buttonColor: AppColors.TEXT_COLOR,
                      onPressed: () => Get.offNamedUntil(
                          Routes.MY_VEHICLES_PAGE, (route) => false),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
        );
        loading(LoadingType.non);
      },
      onError: (error) {
        loading(LoadingType.non);
      },
    );
  }
}
