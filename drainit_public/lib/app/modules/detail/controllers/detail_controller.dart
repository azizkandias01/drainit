import 'package:drainit_flutter/app/modules/detail/models/detail_model.dart';
import 'package:drainit_flutter/app/modules/detail/models/update_report_model.dart';
import 'package:drainit_flutter/app/modules/detail/providers/detail_provider.dart';
import 'package:drainit_flutter/app/modules/detail/providers/update_report_provider.dart';
import 'package:drainit_flutter/app/modules/profile/models/profile_model.dart';
import 'package:drainit_flutter/app/modules/profile/providers/profile_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailController extends GetxController with StateMixin {
  final detail = Detail().obs;
  RxList<UpdateReport> updateReport = <UpdateReport>[].obs;
  GetStorage box = GetStorage();
  final feedbackController = TextEditingController();
  ProfileResponse dataProfile = ProfileResponse();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUpdate();
    await getDetail();
  }

  String convertDate() {
    final DateTime date = DateTime.parse(detail.value.createdAt ?? "");
    return "${date.hour}:${date.minute}:${date.second} ${date.day}/${date.month}/${date.year}";
  }

  Future<void> getDetail() async {
    change(null, status: RxStatus.loading());

    await DetailProvider()
        .getDetail(Get.arguments.toString(), box.read(Routes.TOKEN).toString())
        .then(
      (value) => {
        change(value, status: RxStatus.success()),
        detail.value = value!,
      },
      onError: (err) {
        printError(info: err.toString());
        change(err, status: RxStatus.error());
      },
    );
  }

  Future<void> getUpdate() async {
    change(null, status: RxStatus.loading());
    await UpdateReportProvider()
        .getUpdateReport(
      Get.arguments.toString(),
      box.read(Routes.TOKEN).toString(),
    )
        .then(
      (value) => {
        updateReport.value = value,
        change(value, status: RxStatus.success()),
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }

  Future<void> feedbackMasyarakat(String feedback) async {
    change(null, status: RxStatus.loading());
    return UpdateReportProvider().masyarakatFeedback(
      {
        "feedback_masyarakat": feedback,
      },
      box.read(Routes.TOKEN).toString(),
      detail.value.id.toString(),
    ).then(
      (value) => {
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
      double.parse(
        latlong[0],
      ),
    );
    return latLng;
  }

  Future<void> getAccountProfile() async {
    change(null, status: RxStatus.loading());

    await ProfileProvider()
        .geProfile(detail.value.idMasyarakat.toString())
        .then(
      (value) => {
        change(value, status: RxStatus.success()),
        dataProfile = value!,
      },
      onError: (err) {
        change(err, status: RxStatus.error());
      },
    );
  }
}
