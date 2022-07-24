import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:drainit_petugas/app/modules/detail/models/detail_model.dart';
import 'package:drainit_petugas/app/modules/detail/models/update_laporan_model.dart';
import 'package:drainit_petugas/app/modules/detail/providers/detail_provider.dart';
import 'package:drainit_petugas/app/modules/detail/providers/update_laporan_provider.dart';
import 'package:drainit_petugas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class DetailController extends GetxController with StateMixin {
  final id = Get.arguments[0].toString();
  final geometry = Get.arguments[1].toString();
  List<UpdateLaporan> listUpdate = [];
  Detail detail = Detail();
  late LatLng location;
  var page = 0.obs;
  PageController pageController = PageController();
  TextEditingController updateLaporanController = TextEditingController();

  GetStorage box = GetStorage();
  RxString selectedImagePath = ''.obs;
  RxString selectedImageSize = ''.obs;

  // Crop code
  RxString cropImagePath = ''.obs;
  RxString cropImageSize = ''.obs;

  RxString bytes64Image = ''.obs;
  @override
  void onInit() async {
    super.onInit();
    change(RxStatus.empty());
    await getDetail();
    await getUpdateLaporan();
  }

  // }

  void doneLaporan(String idPengaduan) async {
    change(null, status: RxStatus.loading());
    await UpdateLaporanProvider()
        .doneLaporan(idPengaduan, box.read(Routes.TOKEN))
        .then(
      (resp) {
        getUpdateLaporan();
        updateLaporanController.clear();
        bytes64Image.value = '';
        Get.dialog(
          AlertDialog(
            title: Text('Selesai'),
            content: Text('Laporan berhasil ditandai selesai'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        );
      },
      onError: (e) => change(
        e,
        status: RxStatus.error(),
      ),
    );
  }

  void updateLaporan(
      String id, String judul, String deskripsi, String foto) async {
    change(
      null,
      status: RxStatus.loading(),
    );
    final updateData = {
      'id_pengaduan': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'foto': foto,
    };
    await UpdateLaporanProvider()
        .updateLaporan(updateData, box.read(Routes.TOKEN))
        .then(
      (resp) {
        getUpdateLaporan();
        updateLaporanController.clear();
        bytes64Image.value = '';
        Get.dialog(
          AlertDialog(
            title: Text('Update Laporan'),
            content: Text('Update Laporan Berhasil'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        );
      },
      onError: (e) => change(
        e,
        status: RxStatus.error(),
      ),
    );
  }

  Future<void> getUpdateLaporan() async {
    change(null, status: RxStatus.loading());
    await UpdateLaporanProvider().listUpdate(Get.arguments[0].toString()).then(
      (value) => {
        listUpdate = value,
        change(
          value,
          status: RxStatus.success(),
        ),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  Future<void> notifikasi() async {
    final data = {
      "included_segments": ["Subscribed Users"],
      "app_id": "366b7e82-ce68-488b-8394-4374e0783cc6",
      "contents": {"en": "This is a message, update on your report"},
      "headings": {"en": "Update Laporan"},
      "subtitle": {
        "en": "This is a subtitle, it should only appear on iOS devices"
      }
    };
    change(null, status: RxStatus.loading());
    await UpdateLaporanProvider()
        .notificationUpdate(
            data, "MzQ2ZTY4YTQtY2EzZC00NzBmLWJkOWQtYmE2ZjY5MzYzYjgw")
        .then(
      (value) => {
        print("berhasil"),
      },
      onError: (err) {
        print("gagal");
      },
    );
  }

  Future<void> getDetail() async {
    change(
      null,
      status: RxStatus.loading(),
    );
    await DetailProvider().getDetail(id, box.read(Routes.TOKEN)).then(
      (value) => {
        detail = value!,
        change(value, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  LatLng geoToLatlong(String string) {
    final String substring = string.substring(34, string.length - 2);
    final List<String> latlong = substring.split(',');
    final LatLng latLng = LatLng(
      double.parse(latlong[1]),
      double.parse(latlong[0]),
    );
    return latLng;
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
      print("error");
    }
  }
}
