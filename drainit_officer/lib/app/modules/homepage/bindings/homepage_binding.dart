import 'package:drainit_petugas/app/modules/done_reports/controllers/done_reports_controller.dart';
import 'package:drainit_petugas/app/modules/maps/controllers/maps_controller.dart';
import 'package:drainit_petugas/app/modules/processed_reports/controllers/processed_reports_controller.dart';
import 'package:drainit_petugas/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

import '../controllers/homepage_controller.dart';

class HomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomepageController>(
      HomepageController(),
    );
    Get.put<ProfileController>(
      ProfileController(),
    );
    Get.put<ProcessedReportsController>(
      ProcessedReportsController(),
    );
    Get.put<DoneReportsController>(
      DoneReportsController(),
    );
    Get.lazyPut<MapsController>(
      () => MapsController(),
    );
  }
}
