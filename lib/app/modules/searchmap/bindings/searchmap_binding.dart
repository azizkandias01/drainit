import 'package:get/get.dart';

import '../controllers/searchmap_controller.dart';

class SearchmapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchmapController>(
      () => SearchmapController(),
    );
  }
}
