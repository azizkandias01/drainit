// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:drainit_flutter/app/modules/flood_drainage_list/controllers/flood_drainage_list_controller.dart';
import 'package:drainit_flutter/app/modules/flood_drainage_list/views/flood_drainage_list_view.dart';
import 'package:drainit_flutter/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_flutter/app/modules/profile/views/profile_view.dart';
import 'package:drainit_flutter/app/modules/reports/views/reports_view.dart';
import 'package:drainit_flutter/app/modules/timeline/views/timeline_view.dart';
import 'package:flutter/material.dart';

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
    if (Get.arguments.toString() != "anonymouse") {
      final ProfileC = Get.find<ProfileController>();
    }
    var _selectedIndex = 0.obs;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
    print(Get.arguments);
    List<Widget> _widgetOptions = Get.arguments == "anonymouse"
        ? [
            ReportsView(),
            TimelineView(Get.arguments),
            FloodDrainageListView(),
          ]
        : [
            ReportsView(),
            TimelineView(Get.arguments),
            Text(
              "like",
              style: optionStyle,
            ),
            FloodDrainageListView(),
            ProfileView(),
          ];
    List<GButton> _widgetButton = Get.arguments == "anonymouse"
        ? [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.list,
              text: "Reports",
            ),
            GButton(
              icon: LineIcons.map,
              text: "Maps",
            ),
          ]
        : [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.pen,
              text: "Reports",
            ),
            GButton(
              icon: LineIcons.clock,
              text: 'Likes',
            ),
            GButton(
              icon: LineIcons.map,
              text: 'Search',
            ),
            GButton(
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
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
    );
  }
}
