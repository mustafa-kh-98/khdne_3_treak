import 'package:get/get.dart';

import '../controllers/vehicle_inof_page_controller.dart';

class VehicleInofPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleInofPageController>(
      () => VehicleInofPageController(),
    );
  }
}
