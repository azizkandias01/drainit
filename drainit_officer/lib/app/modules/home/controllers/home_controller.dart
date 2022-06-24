import 'package:drainit_petugas/app/modules/done_reports/controllers/done_reports_controller.dart';
import 'package:drainit_petugas/app/modules/done_reports/views/done_reports_view.dart';
import 'package:drainit_petugas/app/modules/maps/controllers/maps_controller.dart';
import 'package:drainit_petugas/app/modules/maps/views/maps_view.dart';
import 'package:drainit_petugas/app/modules/processed_reports/controllers/processed_reports_controller.dart';
import 'package:drainit_petugas/app/modules/processed_reports/views/processed_reports_view.dart';
import 'package:drainit_petugas/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_petugas/app/modules/profile/views/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeController extends GetxController {
  final doneReportsController = Get.find<DoneReportsController>();
  final processedReportsController = Get.find<ProcessedReportsController>();
  final profileController = Get.find<ProfileController>();
  final mapController = Get.find<MapsController>();
  //List of navbar items
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.hourglass_bottom),
        title: "Diproses",
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.task),
        title: "Selesai",
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.explore),
        title: "Peta",
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
  }

  //navbar view/navbar screen
  List<Widget> widgetOption = [
    ProcessedReportsView(),
    DoneReportsView(),
    MapsView(),
    ProfileView(),
  ];
  PersistentTabController tabController = PersistentTabController(
    initialIndex: 0,
  );

  @override
  void onInit() {
    super.onInit();
    FlutterNativeSplash.remove();
  }
}
