import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/homepage_anonymous_controller.dart';

class HomepageAnonymousView extends GetView<HomepageAnonymousController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomepageAnonymousView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'HomepageAnonymousView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
