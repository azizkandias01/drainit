import 'package:cached_network_image/cached_network_image.dart';
import 'package:drainit_flutter/app/modules/detail/models/detail_model.dart';
import 'package:drainit_flutter/app/modules/detail/providers/detail_provider.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:palette_generator/palette_generator.dart';

import '../models/detail_model.dart';

class DetailController extends GetxController with StateMixin {
  late Detail detail;
  late Color dominantColor;
  @override
  void onInit() {
    super.onInit();
    detail = Detail();
    dominantColor = const Color(0xFFF5F5F5);
    getDominantColor();
    change(null, status: RxStatus.empty());
    getDetail();
  }

  String convertDate() {
    DateTime date = DateTime.parse(detail.createdAt ?? "");
    return "${date.hour}:${date.minute}:${date.second} ${date.day}/${date.month}/${date.year}";
  }

  Future<PaletteGenerator> _updatePaletteGenerator() async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(
        Routes.IMAGEURL + detail.foto!,
      ),
    );
    return paletteGenerator;
  }

  void getDominantColor() {
    _updatePaletteGenerator().then((paletteGenerator) {
      dominantColor = paletteGenerator.dominantColor?.color ?? Colors.white;
    });
  }

  void getDetail() {
    change(null, status: RxStatus.loading());

    DetailProvider().getDetail(Get.arguments.toString()).then(
      (value) => {
        change(value, status: RxStatus.success()),
        detail = value!,
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
