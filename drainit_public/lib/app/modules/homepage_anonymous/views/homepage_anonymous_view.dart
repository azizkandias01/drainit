import 'package:drainit_flutter/app/modules/homepage_anonymous/controllers/homepage_anonymous_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomepageAnonymousView extends GetView<HomepageAnonymousController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomepageAnonymousView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomepageAnonymousView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
