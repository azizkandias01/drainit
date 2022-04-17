import 'dart:convert';
import 'dart:io';

import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../register/providers/register_provider.dart';

class RegisterNextController extends GetxController with StateMixin {
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;

  // Crop code
  RxString cropImagePath = ''.obs;
  RxString cropImageSize = ''.obs;

  RxString bytes64Image = ''.obs;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
  }

  final argument = Get.arguments;

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          '${(File(selectedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb';

      // Crop
      final cropImageFile = await ImageCropper().cropImage(
        sourcePath: selectedImagePath.value,
        aspectRatio: const CropAspectRatio(ratioX: 100, ratioY: 100),
        cropStyle: CropStyle.circle,
        maxWidth: 512,
        maxHeight: 512,
      );
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value =
          '${(File(cropImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb';
      final _bytes = File(cropImagePath.value).readAsBytesSync();
      bytes64Image.value = base64Encode(_bytes);
    } else {
      Get.snackbar(
        'Error',
        'Error saat pemilihan gambar',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void registerUser(
    String name,
    String phone,
    String email,
    String alamat,
    String password,
    String confirmPassword,
    String? foto,
  ) {
    final registerData = {
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'nama': name,
      'no_hp': phone,
      'foto': foto,
      'alamat': alamat,
    };

    change(
      null,
      status: RxStatus.loading(),
    );

    RegisterProvider().registerUser(registerData).then(
      (resp) => {
        change(
          resp,
          status: RxStatus.success(),
        ),
        Get.snackbar(
          'Berhasil',
          'Akun anda sudah berhasil dibuat',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
          snackStyle: SnackStyle.FLOATING,
          duration: const Duration(seconds: 2),
        ),
        Get.offAllNamed(Routes.LOGIN)
      },
      onError: (err) {
        change(
          null,
          status: RxStatus.error('Error occured : $err'),
        );
      },
    );
  }
}
