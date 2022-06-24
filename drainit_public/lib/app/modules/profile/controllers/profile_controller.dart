import 'package:drainit_flutter/app/modules/profile/models/profile_model.dart';
import 'package:drainit_flutter/app/modules/profile/providers/profile_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController with StateMixin {
  late GetStorage box;
  late Profile dataProfile;

  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
    dataProfile = Profile();
    change(null, status: RxStatus.empty());
    getAccountProfile();
  }

  void logoutAccount() {
    showConfirmDialog(
      "Logout",
      "Yakin ingin logout akun?",
      () {
        box.remove(Routes.TOKEN);
        Get.offAllNamed(Routes.LOGIN);
      },
      () {},
    );
  }

  void getAccountProfile() {
    change(null, status: RxStatus.loading());

    ProfileProvider().geProfile(box.read(Routes.TOKEN) as String).then(
      (value) => {
        change(value, status: RxStatus.success()),
        dataProfile = value!,
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  Future<Profile?> getAccountData() async {
    return ProfileProvider().geProfile(box.read(Routes.TOKEN) as String);
  }
}
