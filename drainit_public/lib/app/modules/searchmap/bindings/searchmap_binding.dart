import 'package:drainit_flutter/app/modules/searchmap/controllers/searchmap_controller.dart';
import 'package:get/get.dart';

class SearchmapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchmapController());
  }
}
