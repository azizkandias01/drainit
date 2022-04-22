import 'package:drainit_petugas/app/modules/done_reports/views/done_reports_view.dart';
import 'package:drainit_petugas/app/modules/maps/views/maps_view.dart';
import 'package:drainit_petugas/app/modules/new_reports/views/new_reports_view.dart';
import 'package:drainit_petugas/app/modules/processed_reports/views/processed_reports_view.dart';
import 'package:drainit_petugas/app/modules/profile/views/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class HomeController extends GetxController {
  //List of navbar items
  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.edit_note),
        title: "Laporan",
        textStyle: TextStyle(
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
        textStyle: TextStyle(
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
        textStyle: TextStyle(
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
    NewReportsView(),
    ProcessedReportsView(),
    DoneReportsView(),
    MapsView(),
    ProfileView(),
  ];
  PersistentTabController tabController = PersistentTabController(
    initialIndex: 0,
  );
}
