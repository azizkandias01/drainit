import 'package:drainit_flutter/app/components/constant.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomepageController extends GetxController {
  GetStorage box = GetStorage();
  final String arguments = Get.arguments.toString();
  final visible = 0.obs;
  final profileC = Get.find<ProfileController>();
  final historyC = Get.find<HistoryController>();
  final floodListC = Get.find<FloodDrainageListController>();
  final dataButton = [
    HomeButtonCustom(
      Routes.REPORTS,
      Icons.file_copy_rounded,
      text: "Buat laporan",
      color: [const Color(0xFFFFCA03), primary],
    ),
    HomeButtonCustom(
      Routes.HISTORY,
      Icons.history_rounded,
      text: "Riwayat laporan",
      color: [primary, header],
    ),
    HomeButtonCustom(
      Routes.FLOOD_DRAINAGE_LIST,
      Icons.map_rounded,
      text: "Peta titik",
      color: [primaryVariant, primary],
    ),
  ];

  Future<String> test() {
    return Future.delayed(const Duration(seconds: 2), () => "Hello");
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    //remove the splash screen
    FlutterNativeSplash.remove();
  }
}

class HomeButtonCustom {
  HomeButtonCustom(
    this.route,
    this.icon, {
    required this.text,
    required this.color,
  });
  final String text;
  final List<Color> color;
  final String route;
  final IconData icon;
}
