import 'package:drainit_flutter/app/components/text_poppins.dart';
import 'package:drainit_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashscreenController> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
          const Center(child: TextPoppinsBold(text: "Drainit", fontSize: 50)),
    );
  }
}
