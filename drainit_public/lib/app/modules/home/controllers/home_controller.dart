import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import '../../flood_drainage_list/views/flood_drainage_list_view.dart';
import '../../history/controllers/history_controller.dart';
import '../../history/views/history_view.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../profile/views/profile_view.dart';
import '../../reports/controllers/reports_controller.dart';
import '../../reports/views/reports_view.dart';

class HomeController extends GetxController {
  late GetStorage box;
  final floodDrainageListC = Get.find<FloodDrainageListController>();
  final String arguments = Get.arguments.toString();
  final reportsC = Get.find<ReportsController>();

  bool isUserLogin() {
    if (Get.arguments == 'anonymouse') {
      return false;
    } else {
      return true;
    }
  }

  late List<Widget> widgetOptions;

  List<PersistentBottomNavBarItem> navBarsItems() {
    if (isUserLogin()) {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.pencilRuler),
          title: "Laporan",
          textStyle: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.history),
          title: "Riwayat",
          textStyle: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.map),
          title: "Peta",
          textStyle: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.user),
          title: "Profile",
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    } else {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.pencilRuler),
          title: "Laporan",
          textStyle: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LineIcons.map),
          title: "Peta",
          textStyle: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }
  }

  PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
    box = GetStorage();
    if (Get.arguments != 'anonymouse') {
      print("no account");
      final ProfileC = Get.find<ProfileController>();
      final historyC = Get.find<HistoryController>();
    }
    widgetOptions = !isUserLogin()
        ? [
            ReportsView(),
            FloodDrainageListView(),
          ]
        : [
            ReportsView(),
            HistoryView(),
            FloodDrainageListView(),
            ProfileView(),
          ];
  }

  Function? getToken() {
    return box.read(Routes.TOKEN);
  }

  @override
  void onClose() {}
}
