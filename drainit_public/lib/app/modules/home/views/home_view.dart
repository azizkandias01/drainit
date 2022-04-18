import 'dart:io';

import 'package:drainit_flutter/app/components/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    whiteBar();
    return WillPopScope(
      onWillPop: () async {
        Get.dialog(
          AlertDialog(
            title: Text('Are you sure you want to exit?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Get.back();
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
        );
        return false;
      },
      child: PersistentTabView(
        context,
        controller: controller.tabController,
        screens: controller.widgetOptions,
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
