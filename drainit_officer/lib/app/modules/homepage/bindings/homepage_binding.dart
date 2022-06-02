import 'package:get/get.dart';

import '../controllers/homepage_controller.dart';

class HomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomepageController>(
      HomepageController(),
    );
  }
}
