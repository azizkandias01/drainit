import 'dart:async';

import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashscreenController extends GetxController {
  //TODO: Implement SplashscreenController

  final count = 0.obs;
  late GetStorage box;

  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
  }

  bool isLoggedIn() => box.hasData(Routes.TOKEN);

  @override
  void onReady() {
    super.onReady();
    Timer(const Duration(seconds: 2), () {
      if (isLoggedIn()) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }

  @override
  void onClose() {}
}
