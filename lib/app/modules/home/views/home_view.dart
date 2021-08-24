import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var _selectedIndex = 0.obs;
    const TextStyle optionStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
    List<Widget> _widgetOptions = <Widget>[
      Text(
        'Home',
        style: optionStyle,
      ),
      Text(
        'Likes',
        style: optionStyle,
      ),
      Text(
        'Search',
        style: optionStyle,
      ),
      Text(
        'Profile',
        style: optionStyle,
      ),
      //RegisterView()
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
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
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
