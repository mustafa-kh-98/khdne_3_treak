import 'package:flutter/cupertino.dart';
import 'package:futuer_code/app/core/common/common.dart';
import 'package:futuer_code/app/core/utils/app_storage.dart';
import 'package:futuer_code/app/data/remote/repository/vehicle_repo/vehicle_repo.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/enums.dart';
import '../../../../data/remote/models/vehicle_models/response/my_vehicle_response_dto.dart';

class MyVehiclesPageController extends GetxController {
  late ScrollController scrollController;
  Rx<LoadingType> loading = LoadingType.non.obs;

  ///[API_VARS]///
  final VehicleRepo _repo = VehicleRepo();
  List<MyVehiclesResponseDto> myVehicle = [];

  @override
  void onInit() {
    _getVehicles();
    _getCarTypes();
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  ///[API_VARS]///
  _getVehicles() {
    _repo.getMyVehicles(
      beforeSend: () {
        loading(LoadingType.loading);
      },
      onError: (error) {
        myVehicle = [];
        Common.showToast(
          message: error.toString(),
        );
        loading(LoadingType.non);
      },
      onSuccess: (data) {
        myVehicle = [...data.data];
        loading(LoadingType.non);
      },
    );
  }

  _getCarTypes() {
    _repo.getMyVehiclesType(
      beforeSend: () {},
      onSuccess: (data) {
        AppStorage.cashList(data.data, AppStorage.CARS_TYPE);
      },
      onError: (error) {
        Common.showToast(message: error.toString());
      },
    );
  }
}
