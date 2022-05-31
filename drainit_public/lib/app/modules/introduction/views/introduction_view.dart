import 'package:drainit_flutter/app/modules/introduction/controllers/introduction_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroductionView extends GetView<IntroductionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IntroductionView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'IntroductionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
