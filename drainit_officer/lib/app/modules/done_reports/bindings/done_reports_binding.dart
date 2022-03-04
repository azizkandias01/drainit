import 'package:get/get.dart';

import '../controllers/done_reports_controller.dart';

class DoneReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoneReportsController>(
      () => DoneReportsController(),
    );
  }
}
