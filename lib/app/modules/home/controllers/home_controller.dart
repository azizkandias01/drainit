import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  late GetStorage box;
  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
  }

  Function getToken() {
    return box.read(Routes.TOKEN);
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
