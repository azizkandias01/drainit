import 'package:drainit_petugas/app/modules/done_reports/controllers/done_reports_controller.dart';
import 'package:drainit_petugas/app/modules/maps/controllers/maps_controller.dart';
import 'package:drainit_petugas/app/modules/new_reports/controllers/new_reports_controller.dart';
import 'package:drainit_petugas/app/modules/processed_reports/controllers/processed_reports_controller.dart';
import 'package:drainit_petugas/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => NewReportsController());
    Get.lazyPut(() => ProcessedReportsController());
    Get.lazyPut(() => DoneReportsController());
    Get.lazyPut(() => MapsController());
  }
}
