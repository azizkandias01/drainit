import 'package:drainit_petugas/app/modules/new_reports/controllers/new_reports_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final newReportsController = Get.find<NewReportsController>();
  @override
  Widget build(BuildContext context) {
    final _selectedIndex = 0.obs;

    return Scaffold(
      backgroundColor: Colors.white,
      body: PersistentTabView(
        context,
        controller: controller.tabController,
        screens: controller.widgetOption,
        items: controller.navBarsItems(),
        padding: const NavBarPadding.all(8),
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
