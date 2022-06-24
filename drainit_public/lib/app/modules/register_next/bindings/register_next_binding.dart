import 'package:drainit_flutter/app/modules/register_next/controllers/register_next_controller.dart';
import 'package:get/get.dart';

class RegisterNextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterNextController>(
      () => RegisterNextController(),
    );
  }
}
