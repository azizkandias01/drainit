import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/homepage_anonymous/controllers/homepage_anonymous_controller.dart';
import 'package:get/get.dart';

class HomepageAnonymousBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageAnonymousController>(
      () => HomepageAnonymousController(),
    );
    Get.lazyPut<FloodDrainageListController>(
      () => FloodDrainageListController(),
    );
  }
}
