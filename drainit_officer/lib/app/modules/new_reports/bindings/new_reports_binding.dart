import 'package:get/get.dart';

import '../controllers/new_reports_controller.dart';

class NewReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewReportsController>(
      () => NewReportsController(),
    );
  }
}
