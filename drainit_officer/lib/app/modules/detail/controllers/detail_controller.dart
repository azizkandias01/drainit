import 'dart:async';

import 'package:drainit_petugas/app/modules/detail/models/detail_model.dart';
import 'package:drainit_petugas/app/modules/detail/providers/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailController extends GetxController with StateMixin {
  final id = Get.arguments[0].toString();
  final geometry = Get.arguments[1].toString();
  Detail detail = Detail();
  late LatLng location;
  var page = 0.obs;
  PageController pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.empty());
    getDetail();
  }

  Future<void> getDetail() async {
    DetailProvider().getDetail(id).then(
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
      double.parse(latlong[0]),
      double.parse(
        latlong[1],
      ),
    );
    return latLng;
  }
}
