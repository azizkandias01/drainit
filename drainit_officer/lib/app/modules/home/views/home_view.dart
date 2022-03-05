import 'package:drainit_petugas/app/modules/done_reports/controllers/done_reports_controller.dart';
import 'package:drainit_petugas/app/modules/done_reports/views/done_reports_view.dart';
import 'package:drainit_petugas/app/modules/maps/views/maps_view.dart';
import 'package:drainit_petugas/app/modules/new_reports/controllers/new_reports_controller.dart';
import 'package:drainit_petugas/app/modules/processed_reports/controllers/processed_reports_controller.dart';
import 'package:drainit_petugas/app/modules/profile/controllers/profile_controller.dart';
import 'package:drainit_petugas/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final newReportsController = Get.find<NewReportsController>();
  final doneReportsController = Get.find<DoneReportsController>();
  final processedReportsController = Get.find<ProcessedReportsController>();
  final profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    final _selectedIndex = 0.obs;

    final List<Widget> _widgetOptions = [
      DoneReportsView(),
      DoneReportsView(),
      DoneReportsView(),
      MapsView(),
      ProfileView(),
    ];

    final List<GButton> _widgetButton = [
      const GButton(
        icon: LineIcons.edit,
        text: 'Home',
      ),
      const GButton(
        icon: LineIcons.history,
        text: 'Reports',
      ),
      const GButton(
        icon: LineIcons.checkCircle,
        text: 'Maps',
      ),
      const GButton(
        icon: LineIcons.mapMarked,
        text: 'Maps',
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
              padding: EdgeInsets.symmetric(
                horizontal: 15.h,
                vertical: 8.w,
              ),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8.w,
                activeColor: Colors.black,
                iconSize: 24.sp,
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 12.w,
                ),
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
}
