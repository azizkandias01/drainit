import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorSnackBar(String? error, SnackPosition? snackPosition) {
  Get.rawSnackbar(
    snackStyle: SnackStyle.GROUNDED,
    backgroundColor: Colors.red,
    borderRadius: 5,
    messageText: Text(
      error ?? 'There error',
      maxLines: 30,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeInOut,
    barBlur: 20,
    snackPosition: snackPosition ?? SnackPosition.BOTTOM,
    margin: EdgeInsets.zero,
  );
}

void showSuccessSnackBar(String? body, SnackPosition? snackPosition) {
  Get.rawSnackbar(
    snackStyle: SnackStyle.GROUNDED,
    backgroundColor: Colors.green,
    snackPosition: snackPosition ?? SnackPosition.BOTTOM,
    borderRadius: 5,
    messageText: Text(
      body ?? '',
      maxLines: 30,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeInOut,
    barBlur: 20,
    margin: EdgeInsets.zero,
  );
}

extension ExtendedDouble on double {
  Widget get sizedHeight => SizedBox(
        height: this,
      );
  Widget get sizedWidget => SizedBox(
        width: this,
      );
}
