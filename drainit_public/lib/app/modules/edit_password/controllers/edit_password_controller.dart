// ignore_for_file: avoid_dynamic_calls

import 'package:drainit_flutter/app/modules/edit_password/providers/edit_password_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
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
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) {
    final dataRequest = {
      'current_password': oldPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmPassword,
    };
    EditPasswordProvider()
        .editPassword(
      dataRequest,
      box.read(Routes.TOKEN).toString(),
    )
        .then(
      (value) {
        change(value, status: RxStatus.success());
        showSuccessSnackBar(
          value,
        );
      },
      onError: (error) {
        change(error, status: RxStatus.error());
        showErrorSnackBar(
          error.toString(),
        );
      },
    );
  }
}
