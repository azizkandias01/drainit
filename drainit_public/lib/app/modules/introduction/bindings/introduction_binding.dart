import 'package:drainit_flutter/app/modules/introduction/controllers/introduction_controller.dart';
import 'package:get/get.dart';

class IntroductionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroductionController>(
      () => IntroductionController(),
    );
  }
}
