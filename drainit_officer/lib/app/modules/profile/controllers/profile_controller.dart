import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  late GetStorage box;
  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
  }

  void logoutAccount() {
    box.remove(Routes.TOKEN);
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {}
}
