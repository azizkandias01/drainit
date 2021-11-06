// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/views/flood_drainage_list_view.dart';
import 'package:drainit_flutter/app/modules/history/controllers/history_controller.dart';
import 'package:drainit_flutter/app/modules/history/views/history_view.dart';
import 'package:drainit_flutter/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_flutter/app/modules/profile/views/profile_view.dart';
import 'package:drainit_flutter/app/modules/reports/controllers/reports_controller.dart';
import 'package:drainit_flutter/app/modules/reports/views/reports_view.dart';
import 'package:drainit_flutter/app/modules/timeline/views/timeline_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final floodDrainageListC = Get.find<FloodDrainageListController>();
    final String arguments = Get.arguments.toString();
    final reportsC = Get.find<ReportsController>();
    if (isUserLogin()) {
      final ProfileC = Get.find<ProfileController>();
      final historyC = Get.find<HistoryController>();
    }
    final _selectedIndex = 0.obs;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

    final List<Widget> _widgetOptions = !isUserLogin()
        ? [
            ReportsView(),
            TimelineView(arguments),
            FloodDrainageListView(),
          ]
        : [
            ReportsView(),
            TimelineView(arguments),
            HistoryView(),
            FloodDrainageListView(),
            ProfileView(),
          ];
    final List<GButton> _widgetButton = !isUserLogin()
        ? [
            const GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            const GButton(
              icon: LineIcons.list,
              text: 'Reports',
            ),
            const GButton(
              icon: LineIcons.map,
              text: 'Maps',
            ),
          ]
        : [
            const GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            const GButton(
              icon: LineIcons.pen,
              text: 'Reports',
            ),
            const GButton(
              icon: LineIcons.clock,
              text: 'history',
            ),
            const GButton(
              icon: LineIcons.map,
              text: 'Search',
            ),
            const GButton(
              icon: LineIcons.user,
              text: 'Profile',
            ),
          ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => Center(
          child: _widgetOptions.elementAt(_selectedIndex.value),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: ScreenUtilInit(
            designSize: const Size(414, 896),
            builder: () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 8.w),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8.w,
                activeColor: Colors.black,
                iconSize: 24.sp,
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 12.w),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: _widgetButton,
                selectedIndex: _selectedIndex.value,
                onTabChange: (index) {
                  _selectedIndex.value = index;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isUserLogin() {
    if (Get.arguments == 'anonymouse') {
      return false;
    } else {
      return true;
    }
  }
}
