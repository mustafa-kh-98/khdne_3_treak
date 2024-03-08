import 'package:get/get.dart';

import '../../../../data/remote/models/vehicle_models/response/my_vehicle_response_dto.dart';

class VehicleInofPageController extends GetxController {

  List<Images> images = [];
  late MyVehiclesResponseDto vehicle;

  @override
  void onInit() {
    vehicle = Get.arguments["vehicle"];
    images.addAll([
      Images(id: "1", title: "صورة الميكانيك", url: vehicle.mechanicImage!),
      Images(id: "2", title: "صورة المركبة", url: vehicle.vehicleImage!),
      Images(id: "3", title: "صورة اللوحة", url: vehicle.boardImage!),
      Images(id: "4", title: "صورة الهوية الشخصية", url: vehicle.idImage!),
      Images(id: "5", title: "صورة الوكالة", url: vehicle.delegateImage!),
    ]);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class Images {
  String title;
  String url;
  String id;

  Images({
    required this.id,
    required this.title,
    required this.url,
  });
}
