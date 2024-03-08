import 'package:get/get.dart';

import '../controllers/add_vehicle_page_controller.dart';

class AddVehiclePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddVehiclePageController>(
      () => AddVehiclePageController(),
    );
  }
}
