import 'package:get/get.dart';

import '../controllers/processed_reports_controller.dart';

class ProcessedReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProcessedReportsController>(
      () => ProcessedReportsController(),
    );
  }
}
