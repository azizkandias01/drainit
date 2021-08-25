import 'dart:convert';
import 'dart:io';

import 'package:drainit_flutter/app/modules/register/providers/register_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController with StateMixin<String> {
  late TextEditingController myControllerEmail;
  late TextEditingController myControllerPassword;
  late TextEditingController myControllerPasswordConfirm;
  late TextEditingController myControllerName;
  late TextEditingController myControllerPhoneNumber;
  late TextEditingController myControllerAddress;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  // Crop code
  var cropImagePath = ''.obs;
  var cropImageSize = ''.obs;

  var bytes64Image = ''.obs;

  @override
  void onInit() {
    super.onInit();
    myControllerEmail = TextEditingController();
    myControllerPassword = TextEditingController();
    myControllerPasswordConfirm = TextEditingController();
    myControllerPhoneNumber = TextEditingController();
    myControllerName = TextEditingController();
    myControllerAddress = TextEditingController();
    change(null, status: RxStatus.empty());
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";

      // Crop
      final cropImageFile = await ImageCropper.cropImage(
          sourcePath: selectedImagePath.value,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg);
      cropImagePath.value = cropImageFile!.path;
      cropImageSize.value =
          ((File(cropImagePath.value)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
      final _bytes = File(cropImagePath.value).readAsBytesSync();
      bytes64Image.value = base64Encode(_bytes);
    } else {
      Get.snackbar('Error', 'Error saat pemilihan gambar',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void registerUser(
    String name,
    String phone,
    String email,
    String alamat,
    String password,
    String confirmPassword,
    String foto,
  ) {
    final registerData = {
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "nama": name,
      "no_hp": phone,
      "foto": foto,
      "alamat": alamat,
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
      },
      onError: (err) {
        change(
          null,
          status: RxStatus.error("Error occured : " + err.toString()),
        );
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    myControllerPasswordConfirm.dispose();
    myControllerEmail.dispose();
    myControllerPassword.dispose();
    myControllerPasswordConfirm.dispose();
    myControllerName.dispose();
    myControllerPhoneNumber.dispose();
    myControllerAddress.dispose();
    super.dispose();
  }
}
