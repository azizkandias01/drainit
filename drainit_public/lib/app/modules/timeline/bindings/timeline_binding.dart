import 'package:drainit_flutter/app/modules/timeline/controllers/timeline_controller.dart';
import 'package:get/get.dart';

class TimelineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimelineController>(
      () => TimelineController(),
    );
  }
}
