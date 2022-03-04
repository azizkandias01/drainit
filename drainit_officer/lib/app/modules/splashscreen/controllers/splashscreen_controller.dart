import 'dart:async';

import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashscreenController extends GetxController {
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
    Timer(const Duration(seconds: 1), (){
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
