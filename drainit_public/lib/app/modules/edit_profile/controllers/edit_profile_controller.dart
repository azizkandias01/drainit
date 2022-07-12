import 'package:drainit_flutter/app/modules/edit_profile/providers/update_profile_provider.dart';
import 'package:drainit_flutter/app/modules/profile/models/profile_model.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditProfileController extends GetxController with StateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxString selectedImagePath = ''.obs;
  RxString bytes64Image = ''.obs;
  String dateOfBirth = "";

  ProfileResponse profile = Get.arguments as ProfileResponse;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    nameController.text = profile.data!.nama!;
    emailController.text = profile.data!.email!;
    phoneController.text = profile.data!.telepon!;
    addressController.text = profile.data!.alamat!;
    change(null, status: RxStatus.empty());
  }

  void updateProfile(
    String name,
    String phone,
    String alamat,
    String tanggalLahir,
  ) {
    change(null, status: RxStatus.loading());

    final dataRequest = {
      "id": profile.data!.id,
      "nama": name,
      "telepon": phone,
      "alamat": alamat,
      "tanggal_lahir": tanggalLahir,
    };

    UpdateProvider()
        .editProfile(
      dataRequest,
      box.read(Routes.TOKEN).toString(),
    )
        .then(
      (value) {
        change(value, status: RxStatus.success());
        showSuccessSnackBar(
          "Berhasil update profile",
        );
        Get.offAllNamed(Routes.PROFILE);
      },
      onError: (err) {
        change(err, status: RxStatus.error());
        showErrorSnackBar(
          err.toString(),
        );
      },
    );
  }

  void updateProfilePicture(String foto) {
    change(null, status: RxStatus.loading());
    final dataRequest = {
      "foto_profil": "data:image/jpeg;base64,$foto",
    };

    UpdateProvider()
        .updateProfilePicture(
      dataRequest,
      box.read(Routes.TOKEN).toString(),
    )
        .then(
      (value) {
        change(value, status: RxStatus.success());
      },
      onError: (err) {
        change(err, status: RxStatus.error());
        showErrorSnackBar(
          err.toString(),
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    selectedImagePath.value = '';
    bytes64Image.value = '';
  }
}
