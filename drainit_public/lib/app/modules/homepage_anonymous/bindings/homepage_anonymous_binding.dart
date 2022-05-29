import 'package:get/get.dart';

import '../controllers/homepage_anonymous_controller.dart';

class HomepageAnonymousBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageAnonymousController>(
      () => HomepageAnonymousController(),
    );
  }
}
