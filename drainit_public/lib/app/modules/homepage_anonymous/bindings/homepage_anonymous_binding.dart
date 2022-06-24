import 'package:drainit_flutter/app/modules/homepage_anonymous/controllers/homepage_anonymous_controller.dart';
import 'package:get/get.dart';

class HomepageAnonymousBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageAnonymousController>(
      () => HomepageAnonymousController(),
    );
  }
}
