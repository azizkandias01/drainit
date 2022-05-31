// ignore_for_file: lines_longer_than_80_chars

import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController with StateMixin<String> {
  //key for test
  final nameKey = const Key("name");
  final emailKey = const Key("email");
  final passwordKey = const Key("password");
  final confirmPasswordKey = const Key("confirmPassword");
  final phoneKey = const Key("phone");
  final addressKey = const Key("address");
  final isCheckedKey = const Key("isChecked");
  final nextKey = const Key("next");

  //TexteditingController
  late TextEditingController myControllerEmail;
  late TextEditingController myControllerPassword;
  late TextEditingController myControllerPasswordConfirm;
  late TextEditingController myControllerName;
  late TextEditingController myControllerPhoneNumber;
  late TextEditingController myControllerAddress;

  //controller for hide show password
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isChecked = false.obs;

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

  void validateForm() {
    if (myControllerEmail.text.isEmpty ||
        myControllerPassword.text.isEmpty ||
        myControllerPasswordConfirm.text.isEmpty ||
        myControllerName.text.isEmpty ||
        myControllerPhoneNumber.text.isEmpty ||
        myControllerAddress.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all the fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
      );
    } else if (!GetUtils.isEmail(myControllerEmail.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
      );
    } else if (myControllerPassword.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
      );
    } else if (myControllerPassword.text != myControllerPasswordConfirm.text) {
      Get.snackbar(
        'Error',
        'Password and Confirm Password does not match',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
      );
    } else if (!isChecked.value) {
      Get.snackbar(
        'Error',
        'Please accept the terms and conditions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        snackStyle: SnackStyle.FLOATING,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.toNamed(
        Routes.REGISTER_NEXT,
        arguments: [
          myControllerName.text,
          myControllerPhoneNumber.text,
          myControllerEmail.text,
          myControllerAddress.text,
          myControllerPassword.text,
          myControllerPasswordConfirm.text,
        ],
      );
    }
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
