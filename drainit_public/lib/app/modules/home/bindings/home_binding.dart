import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/modules/history/models/history_model.dart';
import 'package:drainit_flutter/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_flutter/app/modules/reports/controllers/reports_controller.dart';
import 'package:drainit_flutter/app/modules/timeline/controllers/timeline_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<FloodDrainageListController>(
      () => FloodDrainageListController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<TimelineController>(
      () => TimelineController(),
    );
    Get.lazyPut<ReportsController>(
      () => ReportsController(),
    );
    Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
  }
}
