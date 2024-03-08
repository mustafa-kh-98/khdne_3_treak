import 'package:get/get.dart';

import '../controllers/my_vehicles_page_controller.dart';

class MyVehiclesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyVehiclesPageController>(
      () => MyVehiclesPageController(),
    );
  }
}
