import 'package:get/get.dart';

import '../controllers/register_next_controller.dart';

class RegisterNextBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterNextController>(
      () => RegisterNextController(),
    );
  }
}
