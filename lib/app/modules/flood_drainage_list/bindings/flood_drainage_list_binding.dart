import 'package:get/get.dart';

import '../controllers/flood_drainage_list_controller.dart';

class FloodDrainageListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FloodDrainageListController>(
      () => FloodDrainageListController(),
    );
  }
}
