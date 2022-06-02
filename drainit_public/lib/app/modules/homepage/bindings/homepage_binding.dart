import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:drainit_flutter/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_flutter/app/modules/reports/controllers/reports_controller.dart';
import 'package:get/get.dart';

class HomepageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomepageController(),
    );
    Get.lazyPut<FloodDrainageListController>(
      () => FloodDrainageListController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<ReportsController>(
      () => ReportsController(),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
  }
}
