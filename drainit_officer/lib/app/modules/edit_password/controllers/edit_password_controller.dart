import 'package:drainit_petugas/app/modules/edit_password/providers/edit_password_provider.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:drainit_petugas/app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditPasswordController extends GetxController with StateMixin {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final oldPassword = TextEditingController();
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
  }

  void editPassword(
      String oldPassword, String newPassword, String confirmPassword) {
    change(null, status: RxStatus.loading());
    final dataRequest = {
      'current_password': oldPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmPassword
    };
    EditPasswordProvider()
        .editPassword(dataRequest, box.read(Routes.TOKEN).toString())
        .then(
      (value) {
        change(value, status: RxStatus.success());
        showSuccessSnackBar("Berhasil Mengubah Password");
      },
      onError: (error) {
        change(error, status: RxStatus.error());
        showErrorSnackBar(error.toString());
      },
    );
  }
}
