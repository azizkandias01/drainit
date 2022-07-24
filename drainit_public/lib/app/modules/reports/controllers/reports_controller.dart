import 'package:drainit_flutter/app/modules/reports/providers/reports_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:drainit_flutter/app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReportsController extends GetxController with StateMixin {
  final latlng = "".obs;
  final page = 0.obs;
  final isChecked = false.obs;
  late GetStorage box;
  LatLng geometry = const LatLng(0, 0);
  TextEditingController deskripsiController = TextEditingController();
  final isAnonym = Get.arguments.toString() == Routes.HOMEPAGE_ANONYMOUS;

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
      'deskripsi': deskripsiPengaduan,
      'geometry':
          '{"type": "Point", "coordinates": [${geometry.longitude},${geometry.latitude}]}',
    };
    change(
      null,
      status: RxStatus.loading(),
    );
    if (tipePengaduan == "Banjir") {
      if (isAnonym) {
        ReportsProvider()
            .createFloodReportAnon(
          reportData,
        )
            .then(
          (resp) => {
            change(
              resp,
              status: RxStatus.success(),
            ),
            Get.back(),
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
      } else {
        ReportsProvider()
            .createFloodReport(reportData, box.read(Routes.TOKEN).toString())
            .then(
          (resp) => {
            change(
              resp,
              status: RxStatus.success(),
            ),
            Get.offAllNamed(
              Routes.DETAIL,
              arguments: resp.data?.id.toString(),
              parameters: {
                'type': 'report',
              },
            ),
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
    } else {
      if (isAnonym) {
        print("aanon broken");
        ReportsProvider()
            .createBrokenDrainageReportAnon(
          reportData,
        )
            .then(
          (resp) => {
            change(
              resp,
              status: RxStatus.success(),
            ),
            Get.back(),
            showSuccessSnackBar("Laporan berhasil dibuat!"),
          },
          onError: (err) {
            change(
              null,
              status: RxStatus.error('Error occured : $err'),
            );
            print(err);
            showErrorSnackBar("Terjadi kesalahan pada server : $err");
          },
        );
      }
      ReportsProvider()
          .createBrokenDrainageReport(
        reportData,
        box.read(Routes.TOKEN).toString(),
      )
          .then(
        (resp) => {
          change(
            resp,
            status: RxStatus.success(),
          ),
          Get.offAllNamed(
            Routes.DETAIL,
            arguments: resp.data?.id.toString(),
            parameters: {
              'type': 'report',
            },
          ),
          showSuccessSnackBar("Laporan berhasil dibuat!"),
        },
        onError: (err) {
          change(
            null,
            status: RxStatus.error('Error occured : $err'),
          );
          print(err);
          showErrorSnackBar("Terjadi kesalahan pada server : $err");
        },
      );
    }
  }

  Future<String> getAddress(LatLng coordinate) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      coordinate.latitude,
      coordinate.longitude,
    );
    final first = placemarks.first;
    final locality = first.locality ?? '';
    final administrativeArea = first.administrativeArea ?? '';
    final subLocality = first.subLocality ?? '';
    final subAdministrativeArea = first.subAdministrativeArea ?? '';
    final street = first.street ?? '';
    final addressLine =
        '$street, $locality, $subLocality, $subAdministrativeArea, $administrativeArea';
    return addressLine;
  }
}
