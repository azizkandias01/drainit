import 'package:drainit_flutter/app/modules/edit_password/controllers/edit_password_controller.dart';
import 'package:get/get.dart';

class EditPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPasswordController>(
      () => EditPasswordController(),
    );
  }
}
