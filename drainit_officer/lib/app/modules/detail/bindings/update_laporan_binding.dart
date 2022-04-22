import 'package:get/get.dart';

import '../controllers/update_laporan_controller.dart';

class UpdateLaporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateLaporanController());
  }
}
