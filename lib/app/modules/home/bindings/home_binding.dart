import 'package:drainit_flutter/app/modules/searchmap/controllers/searchmap_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SearchmapController>(
      () => SearchmapController(),
    );
  }
}
