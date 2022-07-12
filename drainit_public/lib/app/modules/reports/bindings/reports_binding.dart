import 'package:drainit_flutter/app/modules/reports/controllers/reports_controller.dart';
import 'package:get/get.dart';

class ReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportsController>(
      () => ReportsController(),
    );
  }
}
