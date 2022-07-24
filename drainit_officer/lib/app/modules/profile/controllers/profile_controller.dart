import 'package:drainit_petugas/app/modules/homepage/providers/report_provider.dart';
import 'package:drainit_petugas/app/modules/profile/models/profile_model.dart';
import 'package:drainit_petugas/app/modules/profile/providers/profile_provider.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController with StateMixin {
  GetStorage box = GetStorage();
  ProfileModel profile = ProfileModel();
  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.empty());
    await getAccountProfile();
  }

  void logoutAccount() {
    HomepageProvider().deleteDevice(
        box.read("deviceID").toString(), box.read(Routes.TOKEN) as String);
    box.remove(Routes.TOKEN);
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> getAccountProfile() async {
    change(null, status: RxStatus.loading());

    await ProfileProvider().getProfile(box.read(Routes.TOKEN) as String).then(
      (value) => {
        change(value, status: RxStatus.success()),
        profile.data = value,
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  @override
  void onClose() {}
}
