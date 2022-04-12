import 'dart:convert';
import 'dart:io';

import 'package:drainit_flutter/app/modules/reports/providers/reports_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
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
  LatLng geometry = const LatLng(0, 0);
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
    if (Get.arguments != null) {
      latlng.value = Get.arguments[1].toString();
    }
  }

  void validateReportForm(
    String namaJalan,
    String foto,
    String tipePengaduan,
    String deskripsiPengaduan,
    LatLng geometry,
  ) {
    if (deskripsiController.text.isEmpty) {
      showErrorSnackBar("Deskripsi tidak boleh kosong!");
    } else if (foto.isEmpty) {
      showErrorSnackBar("Foto tidak boleh kosong!");
    } else if (namaJalan.isEmpty) {
      showErrorSnackBar("Lokasi laporan kosong!");
    } else if (!isChecked.value) {
      showErrorSnackBar("Anda belum menyetujui syarat dan ketentuan");
    } else {
      showConfirmDialog(
        "Yakin ingin melaporkan?",
        "Anda telah yakin dan melaporkan leporan ini dengan benar.",
        () => createReport(
          namaJalan,
          foto,
          tipePengaduan,
          deskripsiPengaduan,
          geometry,
        ),
        () => showErrorSnackBar("Laporan gagal dibuat!"),
      );
    }
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
          "{\"type\": \"Point\", \"coordinates\": [${geometry.latitude},${geometry.longitude}]}",
    };
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
        Get.offAllNamed(Routes.HOME),
        showSuccessSnackBar("Laporan berhasil dibuat!"),
      },
      onError: (err) {
        change(
          null,
          status: RxStatus.error('Error occured : $err'),
        );
        showErrorSnackBar("Terjadi kesalahan pada server : $err");
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
      showErrorSnackBar("Gagal mengambil gambar!");
    }
  }
}
