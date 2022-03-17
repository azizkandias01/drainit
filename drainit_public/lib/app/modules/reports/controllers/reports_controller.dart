import 'dart:convert';
import 'dart:io';

import 'package:drainit_flutter/app/modules/reports/providers/reports_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ReportsController extends GetxController with StateMixin {
  final latlng = "".obs;
  final page = 0.obs;
  final isChecked = false.obs;
  late GetStorage box;
  var geometry = LatLng(0, 0);
  TextEditingController deskripsiController = TextEditingController();

  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;

  // Crop code
  RxString cropImagePath = ''.obs;
  RxString cropImageSize = ''.obs;

  RxString bytes64Image = ''.obs;

  @override
  void onInit() {
    super.onInit();
    box = GetStorage();
    change(null, status: RxStatus.empty());
  }

  void createReport(
    String namaJalan,
    String foto,
    String tipePengaduan,
    String deskripsiPengaduan,
    LatLng geometry,
  ) {
    final reportData = {
      'nama_jalan': namaJalan,
      'foto': foto,
      'tipe_pengaduan': tipePengaduan,
      'deskripsi_pengaduan': deskripsiPengaduan,
      'geometry':
          "{\"type\": \"Point\", \"coordinates\": [101.42554722726345,0.5690943750491332]}",
    };
    reportData.forEach((key, value) {
      printError(info: value);
    });
    change(
      null,
      status: RxStatus.loading(),
    );

    ReportsProvider()
        .createReport(reportData, box.read(Routes.TOKEN).toString())
        .then(
      (resp) => {
        change(
          resp,
          status: RxStatus.success(),
        ),
      },
      onError: (err) {
        change(
          null,
          status: RxStatus.error('Error occured : $err'),
        );
      },
    );
  }

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          '${(File(selectedImagePath.value).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb';

      // Crop
      final cropImageFile = await ImageCropper().cropImage(
        sourcePath: selectedImagePath.value,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
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
}
