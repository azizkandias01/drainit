import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:get/get.dart';

class FloodDrainageListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FloodDrainageListController>(
      () => FloodDrainageListController(),
    );
  }
}
