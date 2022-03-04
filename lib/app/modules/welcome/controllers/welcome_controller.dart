import 'dart:async';

import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  //TODO: Implement WelcomeController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    printInfo(info: 'WelcomeController onInit');
    Timer(const Duration(seconds: 2), ()=>Get.offAllNamed(Routes.LOGIN));
  }

  @override
  void onReady() {
    super.onReady();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
