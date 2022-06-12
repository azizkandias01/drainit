import 'package:drainit_petugas/app/modules/done_reports/controllers/done_reports_controller.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomepageController extends GetxController {
  GetStorage box = GetStorage();
  final doneReportsController = DoneReportsController();
  // final processedReportsController = Get.find<ProcessedReportsController>();
  // final profileController = Get.find<ProfileController>();
  // final mapController = Get.find<MapsController>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
