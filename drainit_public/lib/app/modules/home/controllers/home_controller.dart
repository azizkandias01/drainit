import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/views/flood_drainage_list_view.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/modules/history/views/history_view.dart';
import 'package:drainit_flutter/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_flutter/app/modules/profile/views/profile_view.dart';
import 'package:drainit_flutter/app/modules/reports/controllers/reports_controller.dart';
import 'package:drainit_flutter/app/modules/reports/views/reports_view.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage();
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
          icon: const Icon(Icons.edit_note),
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
          icon: const Icon(Icons.history),
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
          icon: const Icon(Icons.explore),
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
          icon: const Icon(Icons.person_outline),
          title: "Profile",
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    } else {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.edit_note),
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
          icon: const Icon(Icons.explore),
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
    initPlatformState();
    FlutterNativeSplash.remove();
    if (Get.parameters['index'] == '1') {
      tabController.index = 1;
    } else if (Get.parameters['index'] == '3') {
      tabController.index = 3;
    }
    if (Get.arguments != 'anonymouse') {
      final profileC = Get.find<ProfileController>();
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

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(Routes.ONE_SIGNAL_APP_ID);
    //minta supaya login dapet user id juga
    OneSignal.shared.setExternalUserId("6c76ed65-c42a-4be1-8ecb-53a4a6761bf8");
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
  }

  @override
  void onClose() {}
}
